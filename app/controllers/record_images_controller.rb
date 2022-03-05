class RecordImagesController < ApplicationController
  def destroy
    @record_image = RecordImage.find(params[:id])
    @record_image.destroy
    redirect_to edit_record_path(@record_image.record.id)
  end
end
