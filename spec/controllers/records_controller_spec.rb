require 'rails_helper'
RSpec.describe RecordsController, type: :controller do
  let(:user) { create(:user) }
  let(:record) { create(:record) }
  context 'POST #create' do
    it '正常に保存される' do
      expect {
        post :create, params: { record: attributes_for(:record), user_id: user.id}
      }.to change(Record, :count).by(1)
    end
  end
end