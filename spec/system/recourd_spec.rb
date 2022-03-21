require 'rails_helper'
describe '投稿のテスト' do
  let(:record) {create(:record, user: user)}
  let(:record2) {create(:record, user: user2)}
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
    context '記録投稿画面' do
      before do
        visit new_record_path(user, record)
      end
      it 'distanceフォームが表示される' do
        expect(page).to have_field 'record[distance]'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end
  end
  describe '編集のテスト' do
    context '自分の記録の編集画面に遷移' do
      it '遷移できる' do
        visit edit_record_path(record)
        expect(current_path).to eq('/records/' + record.id.to_s + '/edit')
      end
    end
    context '他ユーザーの編集画面に遷移' do
      it '遷移できない' do
        visit edit_record_path(record2)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end
end