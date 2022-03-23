require 'rails_helper'
describe 'RecourdsController', type: :request do
  before do
    @user = FactoryBot.create(:user)
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
  describe 'GET #new' do
    it 'newアクションにリクエストすると正常にレスポンスが帰ってくる' do
      get new_record_path
      expect(response.status).to eq 200
    end
  end
  describe 'POST #create' do
    it 'createアクションにリクエストすると正常にレスポンスが帰ってくる' do
      post records_path
      expect(response.status).to eq 200
    end
  end
end
