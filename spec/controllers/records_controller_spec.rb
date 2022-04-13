require 'rails_helper'
RSpec.describe 'RecordsController', type: :controller do
  context 'POST #create' do
    before do
      let(:user) { create(:user) }
      let(:record) { create(:record, user_id: user.id) }
    end
    it '正常に保存される' do
      expect {
        post :create, record: attributes_for(:record)
      }.to change(Record, :count).by(1)
    end
  end
end