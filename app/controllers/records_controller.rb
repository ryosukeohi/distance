class RecordsController < ApplicationController
  def index
    @records = Record.all
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.save
    redirect_to user_path(current_user.id)
  end

  private
  def record_params
    params.require(:record).permit(:distance, :description, record_images_images: [])
  end
end
