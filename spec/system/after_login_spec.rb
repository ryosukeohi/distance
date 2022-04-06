require 'rails_helper'

describe "ログイン後のテスト" do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:record) { create(:record, user_id: user.id) }
  let!(:other_record) { create(:record, user_id: other_user.id) }
  let!(:course) { create(:course, user_id: user.id) }
  let!(:other_course) { create(:course, user_id: other_user.id) }
  let!(:record_image) { create(:record_image, record_id: record.id) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'マイページを押すと自分のユーザー詳細画面に遷移する' do
        my_link = find_all('a')[1].native.inner_text
        my_link = my_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link my_link
        is_expected.to eq '/users/' + user.id.to_s
      end

      it 'ランキングを押すとランキング画面に遷移する' do
        rank_link = find_all('a')[2].native.inner_text
        rank_link = rank_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link rank_link
        is_expected.to eq '/users'
      end
    end
  end

  describe 'コース一覧のテスト' do
    before do
      visit courses_path
    end

    it 'urlが正しい' do
      expect(current_path).to eq '/courses'
    end
    it '自分と他人の投稿のリンク先が正しい' do
      expect(page).to have_link '', href: course_path(course)
      expect(page).to have_link '', href: course_path(other_course)
    end
  end

  describe '記録投稿画面の確認' do
    before do
      visit new_record_path
    end
    context '投稿フォームの確認' do
      it '日付フォームが表示される' do
        expect(page).to have_select('record_start_time_1i')
        expect(page).to have_select('record_start_time_2i')
        expect(page).to have_select('record_start_time_3i')
      end
      it '画像フォームが表示される' do
        expect(page).to have_field 'record[record_image]'
      end
      it '距離フォームが表示される' do
        expect(page).to have_field 'record[distance]'
      end
      it '本文フォームが表示される' do
        expect(page).to have_field 'record[description]'
      end
    end
  end
end