class Admin::UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :require_admin
  before_action :admin_user, only: :destroy

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
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
      redirect_to admin_users_path
      flash[:success] =  "ユーザ「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:success] =  "ユーザ「#{@user.name}」を更新しました"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url
    flash[:danger] = "ユーザ「#{@user.name}」を削除しました"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation,  :image, :introduce, :age, :sex)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def require_admin
      unless current_user.admin?
        flash[:danger] = "管理者ユーザー以外閲覧できません"
        redirect_to root_path
      end
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
