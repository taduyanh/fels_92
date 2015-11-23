class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = current_user.activities
  end

  def show
    @activities = current_user.lessons
  end
end
