class FavoritesController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    current_user.favorite!(@task)
  end

  def destroy
    @task = Favorite.find(params[:id]).task
    current_user.unfavorite!(@task)
  end
end
