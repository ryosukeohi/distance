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

  describe 'トップページ(コース一覧)のテスト' do
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

  describe 'ランキング画面のテスト' do
    before do
      visit users_path
    end
    it 'urlが正しい' do
      expect(current_path).to eq '/users'
    end
    it '自分と他人の詳細のリンク先が正しい' do
      expect(page).to have_link '', href: user_path(user)
      expect(page).to have_link '', href: user_path(other_user)
    end
  end

  describe '記録投稿画面の確認' do
    before do
      visit new_record_path
    end
    context '記録投稿フォームの確認' do
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
      it 'distanceフォームが表示される' do
        expect(page).to have_field 'record[distance]'
      end
      it 'descriptionフォームが表示される' do
        expect(page).to have_field 'record[description]'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end

    context '記録投稿成功の確認' do
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

  describe '記録投稿詳細画面のテスト' do
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
      it '編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_record_path(record)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link '削除', href: record_path(record)
      end
    end

    context '記録編集リンクのテスト' do
      it '編集画面に遷移する' do
      click_link '編集'
      expect(current_path).to eq '/records/' + record.id.to_s + '/edit'
      end
    end

    context '他ユーザーの記録編集画面に遷移' do
      it '遷移できない' do
        visit edit_record_path(other_record)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end

    context '記録削除リンクのテスト' do
      before do
        click_link '削除'
      end
      it '正しく削除される' do
        expect(Record.where(id: record.id).count).to eq 0
      end
      it 'リダイレクト先がユーザー詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

  describe '記録編集画面のテスト' do
    before do
      visit edit_record_path(record)
    end

    context '編集成功のテスト' do
      before do
        @record_old_distance = record.distance
        @record_old_description = record.description
        fill_in 'record[distance]', with: Faker::Lorem.characters(number: 3)
        fill_in 'record[description]', with: Faker::Lorem.characters(number: 20)
        click_button '変更を保存'
      end

      it '距離が正しく更新される' do
        expect(record.reload.distance).not_to eq @record_old_distance
      end
      it '本文が正しく更新される' do
        expect(record.reload.description).not_to eq @record_old_description
      end
      it 'リダイレクト先が投稿詳細画面になっている' do
        expect(current_path).to eq '/records/' + record.id.to_s
      end
    end
  end

  describe 'コース投稿のテスト' do
    before do
      visit new_course_path
    end

    context 'コース投稿フォームの確認' do
      it '検索フォームが表示される' do
        expect(page).to have_field 'address'
        expect(page).to have_button 'Search'
      end
      it '画像フォームが表示される' do
        expect(page).to have_field 'course[course_images_images][]'
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'course[title]'
      end
      it 'distanceフォームが表示される' do
        expect(page).to have_field 'course[distance]'
      end
      it 'descriptionフォームが表示される' do
        expect(page).to have_field 'course[description]'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
    end
  end

  describe 'コース投稿詳細画面のテスト' do
    before do
      visit course_path(course)
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/courses/' + course.id.to_s
      end
      it 'titleが表示される' do
        expect(page).to have_content course.title
      end
      it 'distanceが表示される' do
        expect(page).to have_content course.distance
      end
      it 'descriptionが表示される' do
        expect(page).to have_content course.description
      end
      it '編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_course_path(course)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link '削除' , href: course_path(course)
      end
    end

    context 'コース削除リンクのテスト' do
      before do
        click_link '削除'
      end

      it '正しく削除される' do
        expect(Course.where(id: course.id).count).to eq 0
      end

      it 'リダイレクト先がユーザー詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end

    context 'コース編集リンクのテスト' do
      it '自分の編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/courses/' + course.id.to_s + '/edit'
      end
    end

    context '他のユーザーのコース編集画面に遷移' do
      it '遷移できない' do
        visit edit_course_path(other_course)
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end

  describe '自分のコースの編集画面のテスト' do
    before do
      visit edit_course_path(course)
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/courses/' + course.id.to_s + '/edit'
      end
      it 'title編集フォームが表示される' do
        expect(page).to have_field 'course[title]', with: course.title
      end
      it '画像フォームが表示される' do
        expect(page).to have_field 'course[course_images_images][]'
      end
      it 'distance編集フォームが表示される' do
        expect(page).to have_field 'course[distance]', with: course.distance
      end
      it 'description編集フォームが表示される' do
        expect(page).to have_field 'course[description]', with: course.description
      end
      it '変更を保存 ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end
  end

  describe 'ユーザー情報編集画面のテスト' do
    context '表示内容の確認' do
      before do
        visit edit_user_path(user)
      end
      it 'urlが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '画像フォームが表示さあれる' do
        expect(page).to have_field 'user[profile_image]'
      end
      it 'nameフォームが表示さあれる' do
        expect(page).to have_field 'user[name]'
      end
      it 'introductionフォームが表示される' do
        expect(page).to have_field 'user[introduction]'
      end
      it '保存　ボタンが表示される' do
        expect(page).to have_button '保存'
      end
      it '退会　ボタンが表示される' do
        expect(page).to have_link '退会'
      end
    end

    context 'ユーザー情報編集成功のテスト' do
      before do
        visit edit_user_path(user)
        @user_old_name = user.name
        @user_old_introduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 20)
        click_button '保存'
      end

      it 'nameが正しく変更される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく変更される' do
        expect(user.reload.introduction).not_to eq @user_old_introduction
      end
      it 'リダイレクト先が自分のユーザー詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end

    context '他のユーザー編集画面に遷移' do
      it '遷移できない' do
        visit edit_user_path(other_user)
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end

    context '退会のテスト' do
      before do
        visit confirm_path
      end
      it 'ユーザー情報が削除される' do
        expect { click_link '退会' }.to change {User.count}.by(-1)
      end
      it 'リダイレクト先がトップ画面になっている' do
        click_link '退会'
        expect(current_path).to eq '/'
      end
    end
  end
end