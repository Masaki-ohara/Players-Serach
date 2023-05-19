class FavoritesController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  # POST /favorites or /favorites.json
  def create
    user = current_user
    player = params[:player_id]
    season = params[:season]
    league = params[:league]
    favorite = Favorite.create!(user_id: user.id, player_id: player, season: season, league: league)
    redirect_to request.referer
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    user = current_user
    player = params[:player_id]
    favorite = Favorite.find_by(user_id: user.id, player_id: player)
    favorite.delete
    redirect_to request.referer
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Favorite.find(params[:player_id])
    end
end
