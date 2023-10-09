class FixturesController < ApplicationController
  
  def search
    query_string = URI.encode_www_form({ league: params[:league], data: params[:data] })
    url = URI.parse("https://api-football-v1.p.rapidapi.com/v3/fixtures??#{query_string}")
    # url = URI.parse("https://api-football-v1.p.rapidapi.com/v3/players?#{query_string}")
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
      
  end
end