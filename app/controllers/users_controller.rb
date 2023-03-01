class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your time zone has been updated."
      redirect_to user_path(@user)
    else
      flash[:alert] = "Your time zone could not be updated."
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:time_zone)
  end
end
