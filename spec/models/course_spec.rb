require 'rails_helper'
RSpec.describe Course, type: :model do
  before do
    @course = FactoryBot.build(:course)
  end
  describe 'コース投稿' do
    it 'titleが空では登録できない' do
      @course.title = ''
      @course.valid?
      expect(@course.errors.full_messages).to include "Title can't be blank"
    end
    it 'descriptionが空では登録できない' do
      @course.description = ''
      @course.valid?
      expect(@course.errors.full_messages).to include "Description can't be blank"
    end
    it 'distanceが空では登録できない' do
      @course.distance = ''
      @course.valid?
      expect(@course.errors.full_messages).to include "Distance can't be blank"
    end
    it 'latitudeが空では登録できない' do
      @course.latitude = ''
      @course.valid?
      expect(@course.errors.full_messages).to include "Latitude can't be blank"
    end
    it 'longitudeが空では登録できない' do
      @course.longitude = ''
      @course.valid?
      expect(@course.errors.full_messages).to include "Longitude can't be blank"
    end
    it 'addressが空では登録できない' do
      @course.address = ''
      @course.valid?
      expect(@course.errors.full_messages).to include "Address can't be blank"
    end
  end
end