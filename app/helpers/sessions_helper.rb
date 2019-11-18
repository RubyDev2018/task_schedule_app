module SessionsHelper
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

 # 渡されたユーザーでログインする
 def log_in(user)
   session[:user_id] = user.id
 end
end
