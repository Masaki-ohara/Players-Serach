class PlayersController < ApplicationController
  before_action :require_login, only: %i[favorites]
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  #before_action :set_player, only: %i[search]
  # before_action :set_q, only: %i[search]
  
  def not_authenticated
    flash[:danger] 
    redirect_to login_path
  end

  def index
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
    request["x-rapidapi-key"] = 'd303e74938msh00c29368f24eabcp1dc98djsnc0b438abb423'
    
    response = http.request(request)
    puts response.read_body
    @result = JSON.parse(response.read_body)
    if @result["response"] != []     
      #responseの中身の配列が空じゃなければ検索実行
      @player_id =  @result["response"][0]["player"]["id"]
      @league = @result["response"][0]["statistics"][0]["league"]["id"]
      @imageURL = @result["response"][0]["player"]["photo"]
      @player_name = @result["response"][0]["player"]["name"]
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

  # GET /players/new
  def new
  end

  # GET /players/1/edit
  def edit
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @player = Player.new(player_name: params[:player_name], season: params[:season], league: params[:league])
    #if @player.valid?
    #end
    # if player_name = params[:player_name]
    #   query_string = URI.encode_www_form({ search: player_name, season: params[:season], league: params[:league], })
    #   url = URI.parse("https://api-football-v1.p.rapidapi.com/v3/players?#{query_string}")
    #   http = Net::HTTP.new(url.host, url.port)
    #   http.use_ssl = true
    #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    #   request = Net::HTTP::Get.new(url)
    #   request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
    #   request["x-rapidapi-key"] = 'd303e74938msh00c29368f24eabcp1dc98djsnc0b438abb423'
      
    #   response = http.request(request)
    #   puts response.read_body
    #   @result = JSON.parse(response.read_body)
    #   if @result["response"] != []
    #    player_id = @result["response"][0]["player"]["id"]
       #if @result["response"] == 200
      # redirect_to player_url(@result["response"][0]["player"]["id"])
      #redirect_to player_url(player_id), params:{'season'  => params[:season], 'league'  => params[:league]}, success: "プレイヤー情報を取得に成功しました."
      #else
       # redirect_to search_players_path, notice: "プレイヤー情報が存在しません."
     #end
    #end
    #@player = Player.new
    #@q = Player.ransack(params[:q])
    #@players = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    #@seasons = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def favorites
    # @players = player_id.where(id: player_id = Favorite.where(user_id: current_user.id).select(:player_id))
    # user = User.find(current_user.id)
    # #User.find(params[:user_id])
    # user.favorites = favorites.where(player: player_id)
    # @favorites = current_user.favorites(user.favorites)
    #@player = params[:player_id]
    #@season = params[:season]
   # @league = params[:league]
    # fvorite = params(:player_id, :season, :league)
    #@favorite_players = current_user.favorites.includes(favorite).order(created_at: :desc)
  #  if logged_in?
  #  else
  #   redirect_to login_path 
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
    request["x-rapidapi-key"] = 'd303e74938msh00c29368f24eabcp1dc98djsnc0b438abb423'
    
    response = http.request(request)
    puts response.read_body
    @result = JSON.parse(response.read_body)
  
    if @result["response"] != []   
      @players.push(@result["response"])
      # @image_url = []
      # @player_name = []
      # @image_url.push(id: favorite.player_id, season: favorite.season, leaggue: favorite.league)
      # @player_name.push(id: favorite.player_id, season: favorite.season, leaggue: favorite.league)
      # print 
      # print @player_name
      # @imageURL = @["response"][0]["player"]["photo"]
      # @player_name = @result["response"][0]["player"]["name"]  
    end
   end
   print "選手"
   print @players
    #.includes(:user).order(created_at: :desc)
    # @q = current_user.favorite_players.order('players.created_at DESC').ransack(params[:q])
    # @favorite_players = @q.result(distinct: true).page(params[:page])
  end

  private
  # def set_q
  #   @q = User.ransack(params[:q])
  # end

    # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find(params[:player_id])
  end

    # Only allow a list of trusted parameters through.
  def player_params
    params.require(:player).permit(:player_name, :season, :league)
  end

  def season_params
    params.require(:season).permit(:season)
  end

  def favorites_params
    params.require(:favorites).permit(:player_name, :season, :league)
  end 
  # def search_params
  #   params[:q]&.permit(:player_name, :season)
  # end
end

