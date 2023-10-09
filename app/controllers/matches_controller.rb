# class MatchesController < ApplicationController
# 　def create
#     @match = Match.new(match_params)
#     if @match.save
#       render json: { match: @match }, status: :created
#     else
#       render json: { errors: @match.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def index
#     @matchs = Match.all
#   end

#   private

#   def match_params
#     params.require(:match).permit(:home_team, :away_team)
#   end
# end
class MatchesController < ApplicationController
    before_action :set_match, only: [:show, :update, :destroy]
  
    def index
      @matches = Match.all
      render json: @matches
    end
  
    def show
      render json: @match
    end
  
    def create
      @match = Match.new(match_params)
      if @match.save
        render json: @match, status: :created
      else
        render json: { errors: @match.errors.full_messages }, status: :unprocessable_entity
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
      params.require(:match).permit(:home_team, :away_team)
    end
  end
  