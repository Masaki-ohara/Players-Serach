class MatchesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_match, only: [:show, :update, :destroy]
  
    def index
      @matches = Match.all
    end
  
    def show
      render json: @match
    end

    def new
      @match = current_user.matches.new
    end

    def create
      @match = current_user.matches.new(match_params)
      if @match.save
        redirect_to matches_path, notice: '試合カードの作成が完了しました。'
      else
        flash.now[:danger] = '作成に失敗しました。'
        render 'new'
      end
    end
    

    def update
      if @match.update(match_params)
        render json: @match
      else
        render json: { errors: @match.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @match.destroy
      render json: { message: "Match deleted successfully" }
    end
  
    private
  
    def set_match
      @match = Match.find(params[:id])
    end
  
    def match_params
      params.require(:match).permit(:date, :round, :league, :home_team_name, :away_team_name)
    end
  end
  