class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @activities = current_user.activities
  end

  def show
    @activities = current_user.lessons
  end

  def edit
    redirect_to user_path
  end

  def update
    if user_params[:password]
      current_user.update_with_password(user_params)

      sign_in current_user, :bypass => true
    else
      current_user.update(user_params)
    end

    redirect_to user_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :avatar, :name,
        :password, :password_confirmation, :current_password)
  end
end
