require 'rails_helper'
describe 'RecourdsController', type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'test@test')
    sign_in @user
    @record = FactoryBot.create(:record, user_id: @user.id, distance: 'distance')
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが帰ってくる' do
      get record_path(@record)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿ずみのrecordが存在する' do
      get record_path(@record)
      expect(response.body).to include(@record.distance.to_s)
    end
  end
end
