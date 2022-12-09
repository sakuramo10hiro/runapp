class UsersController < ApplicationController
  def show
    @user = current_user
    @users = User.all
    @courses = Course.all.where(user_id: current_user.id)
  end
end
