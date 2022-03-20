class UsersController < ApplicationController
  def index
    @users = User.find(Record.group(:user_id).where(start_time: Time.current.all_month).order('sum(distance) desc').pluck(:user_id))
    @records = Record.all
  end

  def show
    @user = User.find(params[:id])
    @records = Record.where(user_id: @user.id)
    @distances = @records.where(start_time: Time.current.all_month)
    @total = @distances.all.sum('distance')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
