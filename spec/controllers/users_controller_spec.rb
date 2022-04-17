require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  context 'PATCH #update' do
    it '正常に更新される' do
      user = create(:user)
      patch :update, params: { user: attributes_for(:user, name: 'namename'), id: user }
      user.reload
      expect(user.name).to eq 'namename'
    end
  end

  context 'DELETE #destroy' do
    it '正常に削除される' do
      user = create(:user)
      expect {
        delete :destroy, params: { user: attributes_for(:user), id: user}
      }.to change(User, :count).by(-1)
    end
  end
end