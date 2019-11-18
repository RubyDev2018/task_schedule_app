class UsersController < ApplicationController
  include SessionsHelper
  before_action :require_user, except: [:new, :create]

  def index
    @users = User.all
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
      redirect_to @user, notice: "新規にアカウントを登録しました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザ「#{@user.name}」を更新しました"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザ「#{@user.name}」を削除しました"
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
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation,  :image, :introduce, :age, :sex)
    end

    def require_user
      redirect_to root_path unless current_user
    end
end
