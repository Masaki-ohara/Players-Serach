class PlayersController < ApplicationController
  before_action :require_login, only: %i[favorites]
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'
  
  def not_authenticated
    flash[:danger] ="ログインしてください"
    redirect_to login_path
  end

  def show
    @player = Player.new(player_name: params[:player_name], season: params[:season], league: params[:league])
    if @player.valid?
    query_string = URI.encode_www_form({ search: params[:player_name], season: params[:season], league: params[:league], })
    url = URI.parse("https://api-football-v1.p.rapidapi.com/v3/players?#{query_string}")
    #url = URI.parse("https://api-football-v1.p.rapidapi.com/v3/players?id=#{params[:id]}&season=#{params[:season]}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV["API_KEY"]
    
    response = http.request(request)
    puts response.read_body
    @result = JSON.parse(response.read_body)
    if @result["response"] != []     
      #responseの中身の配列が空じゃなければ検索実行
      @player_id = @result["response"][0]["player"]["id"]
      @league = @result["response"][0]["statistics"][0]["league"]["id"]
      @imageURL = @result["response"][0]["player"]["photo"]
      @lastname = @result["response"][0]["player"]["lastname"]
      @firstname = @result["response"][0]["player"]["firstname"]
      @season = @result["response"][0]["statistics"][0]["league"]["season"]
      @team = @result["response"][0]["statistics"][0]["team"]["name"]
      @age = @result["response"][0]["player"]["age"]
      @natinality = @result["response"][0]["player"]["nationality"]
      @games = @result["response"][0]["statistics"][0]["games"]["appearences"]
      @goal = @result["response"][0]["statistics"][0]["goals"]["total"]
      @shoots = @result["response"][0]["statistics"][0]["shots"]["total"]
      @assists  = @result["response"][0]["statistics"][0]["goals"]["assists"]
      @passes = @result["response"][0]["statistics"][0]["passes"]["total"]
      @accuracy = @result["response"][0]["statistics"][0]["passes"]["accuracy"]
      @tackles = @result["response"][0]["statistics"][0]["tackles"]["total"]
      @blocks = @result["response"][0]["statistics"][0]["tackles"]["blocks"]
      @interceptions = @result["response"][0]["statistics"][0]["tackles"]["interceptions"]
      @duels = @result["response"][0]["statistics"][0]["duels"]["total"]
      @won = @result["response"][0]["statistics"][0]["duels"]["won"]
      @dribbles = @result["response"][0]["statistics"][0]["dribbles"]["attempts"]
      @success = @result["response"][0]["statistics"][0]["dribbles"]["success"]
      @saves = @result["response"][0]["statistics"][0]["goals"]["saves"]
    end
   else
    #redirect_to search_players_path
    flash.now[:danger] = "プレイヤー情報が存在しません."
    render :search
  end
  end

  def search
    @player = Player.new(player_name: params[:player_name], season: params[:season], league: params[:league])
  end

  def favorites
    @favorite_players = Favorite.where(user_id: current_user.id)
    @players = []
    @favorite_players.each do |favorite|
      puts favorite
      query_string = URI.encode_www_form({id: favorite.player_id, season: favorite.season, league: favorite.league })
    url = URI.parse("https://api-football-v1.p.rapidapi.com/v3/players?#{query_string}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = ENV["API_KEY"]
    
    response = http.request(request)
    puts response.read_body
    @result = JSON.parse(response.read_body)
  
    if @result["response"] != []   
      @players.push(@result["response"])
    end
   end
   print "選手"
   print @players
  end

  private
end

