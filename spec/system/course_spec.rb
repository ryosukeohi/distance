require 'rails_helper'
describe '投稿のテスト' do
  let(:course) {create(:course, user: user)}
  let(:course2) {create(:course2, user: user2)}
  let(:user) {create(:user)}
  let(:user2) {create(:user)}
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    visit courses_path
  end
  describe '表示テスト' do
    context 'コース投稿画面' do
      before do
        visit new_course_path(user, course)
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'course[title]'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end
  end
  describe '編集のテスト' do
    context '自分のコースの編集画面に遷移' do
      it '遷移できる' do
        visit edit_course_path(user, course)
        expect(current_path).to eq('/users/' + user.id.to_s + '/courses/' + course.id.to_s + '/edit')
      end
    end
    context '他ユーザーの編集画面に遷移' do
      it '遷移できない' do
        visit edit_course_path(user, course2)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end
end