class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to user_path(current_user.id)
    end
  end

  def help
  end

  def about

  end
end
