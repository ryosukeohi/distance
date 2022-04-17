require 'rails_helper'
RSpec.describe RecordsController, type: :controller do
  let(:user) { create(:user) }
  let(:record) { create(:record, user: user) }
  before do
    sign_in user
  end
  context 'POST #create' do
    it '正常に保存される' do
      expect {
        post :create, params: { record: attributes_for(:record), user_id: user.id}
      }.to change(Record, :count).by(1)
    end
  end

  context 'PATCH #update' do
    it '正常に更新される' do
      record = create(:record, user: user)
      patch :update, params: { record: attributes_for(:record, distance: 7), id: record, user_id: user.id}
      record.reload
      expect(record.distance).to eq 7
    end
  end
end