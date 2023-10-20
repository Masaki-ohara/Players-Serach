class UserSessionsController < ApplicationController
  def new 
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, success: ('ログインに成功しました')
    else
      flash[:alert] = 'ログインに失敗しました.'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, success: ('ログアウトしました')
  end
end
