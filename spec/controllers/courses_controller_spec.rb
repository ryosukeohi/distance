require 'rails_helper'
RSpec.describe CoursesController, type: :controller do
  let(:user) { create(:user) }
  let(:course) { create(:course, user: user) }
  before do
    sign_in user
  end
  context 'POST #create' do
    it '正常に保存される' do
      expect {
        post :create, params: { course: attributes_for(:course), user_id: user.id}
      }.to change(Course, :count).by(1)
    end
  end

  context 'PATCH #update' do
    it '正常に更新される' do
      course = create(:course, user: user)
      patch :update, params: { course: attributes_for(:course, distance: 7), id: course, user_id: user.id}
      course.reload
      expect(course.distance).to eq 7
    end
  end

  context 'DELETE #destroy' do
    it '正常に削除される' do
      course = create(:course, user: user)
      expect {
        delete :destroy, params: { course: attributes_for(:course), user_id: user.id, id: course}
      }.to change(Course, :count).by(-1)
    end
  end
end