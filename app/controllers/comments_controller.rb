class CommentsController < ApplicationController
    # def create

    #     @prediction = Prediction.find(params[:prediction_id])
    #     @comment = current_user.comments.build(comment_params)
 
    #     # @comment.user = current_user
    #     if @comment.save
    #       redirect_to matches_path, success: '投稿しました'
    #       # respond_to do |format|
    #       #   format.html { redirect_to prediction_path(@prediction), notice: 'コメントが投稿されました。' }
    #       #   format.js # comments/create.js.erb を呼び出す
    #     else
    #       redirect_to matches_path
    #       flash[:danger] = "投稿できませんでした"
    #       # render 'predictions/show'
    #     end
    # end
    # def create
    #   user_id = params[:user_id]
    #   match_id = params[:match_id] 
    #   @prediction = Prediction.find(params[:prediction_id])
    #   @comment = current_user.comments.build(comment_params)
    
    #   if @comment.save
    #     redirect_to matches_path, notice: 'コメントが投稿されました'
    #   else
    #     flash[:danger] =  @comment.errors.full_messages.join(', ')
    #     redirect_to matches_path
    #     # (prediction: prediction.id)
    #   end
    # end
  # app/controllers/comments_controller.rb
  def new
    @comment = Comment.new(params_comment)
  end

  def create
    @match = Match.find(params[:match_id])
    @prediction = Prediction.find(params[:prediction_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to match_prediction_path(@prediction.match, @prediction), success: 'コメントが投稿されました'
    else
      flash[:danger] = @comment.errors.full_messages.join(', ')
      redirect_to match_prediction_path(@prediction.match, @prediction)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

    
    
      
    # def create
    #     @prediction = Prediction.find(params[:prediction_id])
    #     @comment = @prediction.comments.new(comment_params)
    #     @comment.user = current_user
      
    #     if @comment.save
    #     #   redirect_to prediction_path(@prediction), 
    #       notice: 'コメントが投稿されました。'
    #     else
    #       flash[:danger] = 'コメントの投稿に失敗しました'
    #     #   redirect_to match_prediction_path(@prediction)
    #     end
    #   end
      
      private
      
      def comment_params
        params.require(:comment).permit(:content, :prediction_id, :match_id, :user_id)
      end
    end
      
      
#   def create
#      @comment = @prediction.comments.build(comment_params)
#      if @comment.save
#         redirect_to match_prediction_path(@prediction), notice: 'コメントが投稿されました'
#       else
#         flash[:danger] = 'コメントの投稿に失敗しました'
#         redirect_to match_prediction_path(@prediction)
#         end
#       end
  
    
#       private
    
#       def comment_params
#         params.require(:comment).permit(:user_id, :prediction_id,:content)
#       end
#     end

# end
