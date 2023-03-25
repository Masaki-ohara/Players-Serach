class GamesController < ApplicationController

  def search
  end

  def show
    @league = params[:league]
    @season = params[:season]
  end

end
