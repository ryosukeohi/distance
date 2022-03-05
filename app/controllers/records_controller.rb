class RecordsController < ApplicationController
  def show
    @record = Record.find(params[:id])
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    @record.save
    redirect_to record_path(@record.id)
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    @record.update(record_params)
    redirect_to record_path(@record.id)
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to user_path(current_user.id)
  end

  private
  def record_params
    params.require(:record).permit(:start_time, :distance, :description, record_images_images: [])
  end
end
