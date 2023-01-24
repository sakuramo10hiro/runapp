class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all
    @courses = Course.all.where(user_id: current_user.id)
  end

  before_action :set_user, only: [:followings, :followers]
    def followings
      @users = @user.followings
    end
  
    def followers
      @users = @user.followers
    end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
end
