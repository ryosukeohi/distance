class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @records = current_user.records
    @month = params[:month] ? Date.parse(params[month]) : Time.zone.today
    @distances = Record.where(created_at: @month.all_month).where(user_id: current_user.id)
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

  def mycourse
    @mycourses = current_user.courses
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
