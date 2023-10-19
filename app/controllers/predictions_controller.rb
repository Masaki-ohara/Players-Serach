class PredictionsController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :index, :edit]
  before_action :set_prediction, only: [:destroy, :show, :edit, :update]

  def not_authenticated
    flash[:danger] ="ログインしてください"
    redirect_to login_path
  end
  

  def show
    @match = Match.find(params[:match_id])
    @prediction = Prediction.find(params[:id])
  end

  def new
    @match = Match.find(params[:match_id])
    @prediction = Prediction.new(match: @match, user: current_user)
    @prediction_match = [@match.home_team_name, @match.away_team_name]
  end

  def index
    @predictions = Prediction.all
  end

  # def create
  #   user_id = params[:user_id]
  #   match_id = params[:match_id]      
  #   @prediction = current_user.predictions.new(prediction_params)
  
  #   if @prediction.save
  #     redirect_to matches_path, notice: '予想を投稿しました。'
  #   else
  #     flash.now[:danger] = '投稿に失敗しました。'
  #     render :new
  #   end
  # end
  def create
    user_id = params[:user_id]
    match_id = params[:match_id]  
    # binding.pry    
    @prediction = current_user.predictions.new(prediction_params)
    # {match_id: prediction_params[:match_id], user_id: prediction_params[:user_id], home_score: prediction_params[:home_score], away_score: prediction_params[:away_score], draw: prediction_params[:draw], comment: prediction_params[:comment]}

    # if params[:draw] == "true"
    #   @prediction.draw = true
    #   @prediction.predicted_winner = nil
    #   @prediction.predicted_loser = nil
    # end
  
    if @prediction.save
      redirect_to matches_path, notice: '予想を投稿しました。'
    else
      flash[:danger] = @prediction.errors.full_messages.join(', ')
      redirect_to new_match_prediction_path(match_id: match_id)
    end
  end

  # def edit
  #   @match = current_user.Match.find(params[:match_id])
  #   @prediction = current_user.Prediction.find(params[:id])
  # end
  # def edit
  #   @prediction = Prediction.find(params[:id])
  # end
  def edit
    # binding.pry
    @prediction = Prediction.find(params[:id])  
    # binding.pry

    @match = Match.find(params[:match_id])
  end
  
  # def update
  #   @prediction = prediction.find(params[:id])
  #   @match = match.find(params[:match_id])
  #   if @prediction.update(prediction_params)
  #     redirect_to match_prediction_path(@match, @prediction), notice: '更新しました'
  #   else
  #     render :edit
  #   end
  # end  
  def update
    @prediction = Prediction.find(params[:id])
    @match = Match.find(params[:match_id]) 
    if @prediction.update(prediction_params)
      redirect_to match_prediction_path(@prediction), notice: '更新しました'
    else
      render :edit
    end
  end
  

  def destroy
    @prediction.destroy!
    redirect_to matches_path, notice: '投稿を削除しました。'
  end

  private

  def prediction_params
    params.require(:prediction).permit(:match_id, :user_id, :home_score, :away_score, :predicted_winner, :predicted_loser, :draw, :comment)
  end

  def set_prediction
    @prediction = Prediction.find(params[:id])
  end
end
