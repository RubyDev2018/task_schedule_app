class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @q = @user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(20).recent
    @favorites_tasks = @user.favorites_tasks
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to @user
      flash[:success] = "新規にアカウントを登録しました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:success] = "ユーザ「#{@user.name}」を更新しました"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url
    flash[:danger] =  "ユーザ「#{@user.name}」を削除しました"
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    # @users = @user.followings.paginate(page: params[:page])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :introduce, :birthday, :sex)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "他のユーザー情報は編集はできません。"
        redirect_to(root_url)
      end
    end
end
