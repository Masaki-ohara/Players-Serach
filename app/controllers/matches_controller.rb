class MatchesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_match, only: [:show, :update, :destroy, :edit]
  before_action :login_match, only: [:edit, :destroy, :update]
  
    def index
      @matches = Match.all
    end
  
    def show
      @match = Match.find(params[:id])
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


    def edit
      @match = Match.find(params[:id])
    end
    
    def update
      @match = Match.find(params[:id])
      if @match.update(match_params)
        redirect_to match_path(@match), notice: '試合カードの更新が完了しました。'
      else
        flash.now[:danger] = '更新に失敗しました。'
        render 'edit'
      end
    end

    def destroy
      @match.destroy!
      redirect_to matches_path, success: '試合カードの削除が完了しました。'
    end
  
    private
  
    def set_match
      @match = Match.find(params[:id])
    end
  
    def match_params
      params.require(:match).permit(:date, :round, :league, :home_team_name, :away_team_name)
    end

    def login_match
      unless Match.find(params[:id]).user.id.to_i == current_user.id
        redirect_to matches_path(current_user)
      end
    end
  end
  