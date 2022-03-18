require 'rails_helper'
RSpec.describe Record, type: :model do
  before do
    @record = FactoryBot.build(:record)
  end
  describe '記録投稿' do
    it 'distanceが空では登録できない' do
      @record.distance = ''
      @record.valid?
      expect(@record.errors.full_messages).to include "Distance can't be blank"
    end
  end
end