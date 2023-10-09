class PredictionsController < ApplicationController
    def create
      @prediction = Prediction.new(prediction_params)
      @prediction.user_id = current_user.id
  
      if @prediction.save
        redirect_to @prediction, notice: '予想を投稿しました。'
      else
        render :new
      end
    end
  
    private
  
    def prediction_params
      params.require(:prediction).permit(:match_id, :predicted_winner)
    end
  end
  