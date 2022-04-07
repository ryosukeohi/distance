require 'rails_helper'

describe "ログイン後のテスト" do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:record) { create(:record, user_id: user.id) }
  let!(:other_record) { create(:record, user_id: other_user.id) }
  let!(:course) { create(:course, user_id: user.id) }
  let!(:other_course) { create(:course, user_id: other_user.id) }

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
        expect(page).to have_select('record_start_time_4i')
        expect(page).to have_select('record_start_time_5i')
      end
      it '画像フォームが表示される' do
        expect(page).to have_field 'record[record_images_images][]'
      end
      it '距離フォームが表示される' do
        expect(page).to have_field 'record[distance]'
      end
      it '本文フォームが表示される' do
        expect(page).to have_field 'record[description]'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end

    context '投稿成功の確認' do
      before do
        select_date("2022,April,5", from: "日付")
        fill_in 'record[distance]', with: Faker::Lorem.characters(number: 3)
        fill_in 'record[description]', with: Faker::Lorem.characters(number: 20)
      end

      it '正しく保存される' do
        expect { click_button '投稿' }.to change(user.records, :count).by(1)
      end
      it 'リダイレクト先が投稿の詳細画面になっている' do
        click_button '投稿'
        expect(current_path).to eq '/records/' + Record.last.id.to_s
      end
    end
  end

  describe '投稿詳細画面のテスト' do
    before do
      visit record_path(record)
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/records/' + record.id.to_s
      end
      it '日付が表示される' do
        expect(page).to have_content record.start_time.strftime('%Y/%m/%d')
      end
      it '本文が表示される' do
        expect(page).to have_content record.description
      end
      it '距離が表示される' do
        expect(page).to have_content record.distance
      end
    end
  end
end