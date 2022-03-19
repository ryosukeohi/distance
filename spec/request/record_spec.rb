require 'rails_helper'
describe 'RecourdsController', type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'test@test')
    @record = FactoryBot.create(:record, user_id: @user.id, distance: 'distance', start_time: 'start_time')
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが帰ってくる' do
      get record_path(@record)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿ずみのrecordが存在する' do
      get record_path(@record)
      expect(response.body). to eq include(@record.distance)
    end
  end
end
