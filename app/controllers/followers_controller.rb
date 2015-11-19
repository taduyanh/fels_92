class FollowersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = case params[:type]
      when "following"
        current_user.following
      when "follower"
        current_user.followers
      else
        User.exclude(current_user).all
    end
  end

  def create
    @user = User.find params[:to_id]
    current_user.follow @user
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js { render 'follow' }
    end
  end

  def destroy
    @user = Follower.find(params[:id]).to_user
    current_user.unfollow @user
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js { render 'follow' }
    end
  end
end
