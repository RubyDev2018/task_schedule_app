class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)

    if user&.authenticate(session_params[:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
      flash[:success] = 'ログインしました。'
    else
      flash.now[:danger] = "メールアドレス又はパスワードが間違っています。"
      render :new
    end
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーがログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
    flash[:danger] = 'ログアウトしました'
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
