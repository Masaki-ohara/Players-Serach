class FavoritesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

 # before_action :set_player

  
  # POST /favorites or /favorites.json
  def create
    # @player_favorite = Favorite.new(user_id: current_user.id, player_id: params[:player_id])
    # @player_favorite.save
    #@player = Player.find(params[:@player_id])
    user = current_user
    player = params[:player_id]
    season = params[:season]
    league = params[:league]
    favorite = Favorite.create!(user_id: user.id, player_id: player, season: season, league: league)
    # if favorite.save
    #   flash[:notice] = 'お気に入り登録しました'
    # else
    #   flash[:alert] = 'お気に入り登録できませんでした'
    # end

    # redirect_back fallback_location: root_path, success: "お気に入りに登録しました"
    redirect_to request.referer
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    #@player = Player.find(params[:@player_id]
    user = current_user
    player = params[:player_id]
    favorite = Favorite.find_by(user_id: user.id, player_id: player)
    favorite.delete
    redirect_to request.referer
    # redirect_back fallback_location: root_path, success: "お気に入りを解除しました"
    # respond_to do |format|
    #   format.html { redirect_to favorites_url, notice: "Favorite was successfully destroyed." }
    #   format.json { head :no_content }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Favorite.find(params[:player_id])
    end

    # def authenticate
    #   redirect_to login_path 
    # end  

    # def logged_in? # <-- 追記するメソッド
    #   (current_user && current_user[:status] != Settings.user_status_retired)
    # end
end
