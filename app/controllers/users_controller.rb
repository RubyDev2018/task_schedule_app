class UsersController < ApplicationController
  before_action :require_user
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
    @favorites_tasks = @user.favorites_tasks
  end

  private
    def require_user
      redirect_to root_path unless current_user
    end
end
