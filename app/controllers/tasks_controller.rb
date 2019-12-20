class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # Task.where(user_id: current_user.id)
    # current_user = User.find_by(id: session[:user_id])
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true).undone.page(params[:page]).per(20).recent

    respond_to do |format|
      format.html
      format.csv { send_data current_user.tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def done
    # Task.where(user_id: current_user.id)
    # current_user = User.find_by(id: session[:user_id])
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true).done.page(params[:page]).per(20).recent

    respond_to do |format|
      format.html
      format.csv { send_data current_user.tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end

    render 'index'
  end

  def calendar
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
    @comment = Comment.new
    @comments = @task.comments
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to user_url(@task.user.id)
      flash[:success] = "タスク「#{@task.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to  user_url(@task.user.id)
    flash[:danger] = "タスク「#{@task.name}」を削除しました。"
  end

  def create
    @task = current_user.tasks.new(task_params)
    if params[:back].present?
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      logger.debug "task: #{@task.attributes.inspect}"
      redirect_to user_url(@task.user.id)
      flash[:success] = "タスク「#{@task.name}」を登録しました!"
    else
      render :new
    end
  end

  def finish
   @task = Task.find(params[:id])
   @task.update_attribute(:done, true)
   redirect_to user_url(@task.user.id)
  end

  def unfinish
   @task = Task.find(params[:id])
   @task.update_attribute(:done, false)
   redirect_to user_url(@task.user.id)
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def import
    if  params[:file].blank?
      redirect_to user_url(current_user.id)
      flash[:danger] =  "インポートするCSVファイルを選択してください"
    else
      num = current_user.tasks.import(params[:file])
      redirect_to user_url(current_user.id)
      flash[:success] =  "#{num.to_s}件のタスクを追加しました"
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :description, :image, :due_date, :state, :start, :end)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def set_task
      @task = Task.find(params[:id])
    end

end
