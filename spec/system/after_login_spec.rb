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

  # describe 'ヘッダーのテスト' do
  #   context 'リンクの内容を確認' do
  #     subject { current_path }

  #     it 'マイページを押すと自分のユーザー詳細画面に遷移する' do
  #       my_link = find_all('a')[1].native.inner_text
  #       my_link = my_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #       click_link my_link
  #       is_expected.to eq '/users/' + user.id.to_s
  #     end

  #     it 'ランキングを押すとランキング画面に遷移する' do
  #       rank_link = find_all('a')[2].native.inner_text
  #       rank_link = rank_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
  #       click_link rank_link
  #       is_expected.to eq '/users'
  #     end
  #   end
  # end

  # describe 'トップページ(コース一覧)のテスト' do
  #   before do
  #     visit courses_path
  #   end

  #   it 'urlが正しい' do
  #     expect(current_path).to eq '/courses'
  #   end
  #   it '自分と他人の投稿のリンク先が正しい' do
  #     expect(page).to have_link '', href: course_path(course)
  #     expect(page).to have_link '', href: course_path(other_course)
  #   end
  # end

  # describe '記録投稿画面の確認' do
  #   before do
  #     visit new_record_path
  #   end
  #   context '投稿フォームの確認' do
  #     it '日付フォームが表示される' do
  #       expect(page).to have_select('record_start_time_1i')
  #       expect(page).to have_select('record_start_time_2i')
  #       expect(page).to have_select('record_start_time_3i')
  #       expect(page).to have_select('record_start_time_4i')
  #       expect(page).to have_select('record_start_time_5i')
  #     end
  #     it '画像フォームが表示される' do
  #       expect(page).to have_field 'record[record_images_images][]'
  #     end
  #     it 'distanceフォームが表示される' do
  #       expect(page).to have_field 'record[distance]'
  #     end
  #     it 'descriptionフォームが表示される' do
  #       expect(page).to have_field 'record[description]'
  #     end
  #     it '投稿ボタンが表示される' do
  #       expect(page).to have_button '投稿'
  #     end
  #   end

  #   context '投稿成功の確認' do
  #     before do
  #       select_date("2022,April,5", from: "日付")
  #       fill_in 'record[distance]', with: Faker::Lorem.characters(number: 3)
  #       fill_in 'record[description]', with: Faker::Lorem.characters(number: 20)
  #     end

  #     it '正しく保存される' do
  #       expect { click_button '投稿' }.to change(user.records, :count).by(1)
  #     end
  #     it 'リダイレクト先が投稿の詳細画面になっている' do
  #       click_button '投稿'
  #       expect(current_path).to eq '/records/' + Record.last.id.to_s
  #     end
  #   end
  # end

  # describe '投稿詳細画面のテスト' do
  #   before do
  #     visit record_path(record)
  #   end

  #   context '表示内容の確認' do
  #     it 'urlが正しい' do
  #       expect(current_path).to eq '/records/' + record.id.to_s
  #     end
  #     it '日付が表示される' do
  #       expect(page).to have_content record.start_time.strftime('%Y/%m/%d')
  #     end
  #     it '本文が表示される' do
  #       expect(page).to have_content record.description
  #     end
  #     it '距離が表示される' do
  #       expect(page).to have_content record.distance
  #     end
  #     it '編集リンクが表示される' do
  #       expect(page).to have_link '編集', href: edit_record_path(record)
  #     end
  #     it '削除リンクが表示される' do
  #       expect(page).to have_link '削除', href: record_path(record)
  #     end
  #   end

  #   context '編集リンクのテスト' do
  #     it '編集画面に遷移する' do
  #     click_link '編集'
  #     expect(current_path).to eq '/records/' + record.id.to_s + '/edit'
  #     end
  #   end

  #   context '他ユーザーの編集画面に遷移' do
  #     it '遷移できない' do
  #       visit edit_record_path(other_record)
  #       expect(current_path).to eq('/users/' + user.id.to_s)
  #     end
  #   end

  #   context '削除リンクのテスト' do
  #     before do
  #       click_link '削除'
  #     end
  #     it '正しく削除される' do
  #       expect(Record.where(id: record.id).count).to eq 0
  #     end
  #     it 'リダイレクト先がユーザー詳細画面になっている' do
  #       expect(current_path).to eq '/users/' + user.id.to_s
  #     end
  #   end
  # end

  # describe '投稿編集画面のテスト' do
  #   before do
  #     visit edit_record_path(record)
  #   end

  #   context '編集成功のテスト' do
  #     before do
  #       @record_old_distance = record.distance
  #       @record_old_description = record.description
  #       fill_in 'record[distance]', with: Faker::Lorem.characters(number: 3)
  #       fill_in 'record[description]', with: Faker::Lorem.characters(number: 20)
  #       click_button '変更を保存'
  #     end

  #     it '距離が正しく更新される' do
  #       expect(record.reload.distance).not_to eq @record_old_distance
  #     end
  #     it '本文が正しく更新される' do
  #       expect(record.reload.description).not_to eq @record_old_description
  #     end
  #     it 'リダイレクト先が投稿詳細画面になっている' do
  #       expect(current_path).to eq '/records/' + record.id.to_s
  #     end
  #   end
  # end

  describe 'コース投稿のテスト' do
    before do
      visit new_course_path
    end

    # context '投稿フォームの確認' do
    #   it '検索フォームが表示される' do
    #     expect(page).to have_field 'address'
    #     expect(page).to have_button 'Search'
    #   end
    #   it '画像フォームが表示される' do
    #     expect(page).to have_field 'course[course_images_images][]'
    #   end
    #   it 'titleフォームが表示される' do
    #     expect(page).to have_field 'course[title]'
    #   end
    #   it 'distanceフォームが表示される' do
    #     expect(page).to have_field 'course[distance]'
    #   end
    #   it 'descriptionフォームが表示される' do
    #     expect(page).to have_field 'course[description]'
    #   end
    #   it '投稿ボタンが表示される' do
    #     expect(page).to have_button '投稿'
    #   end
    # end
  end

  # describe 'コース投稿詳細画面のテスト' do
  #   before do
  #     visit course_path(course)
  #   end

  #   context '表示内容の確認' do
  #     it 'urlが正しい' do
  #       expect(current_path).to eq '/courses/' + course.id.to_s
  #     end
  #     it 'titleが表示される' do
  #       expect(page).to have_content course.title
  #     end
  #     it 'distanceが表示される' do
  #       expect(page).to have_content course.distance
  #     end
  #     it 'descriptionが表示される' do
  #       expect(page).to have_content course.description
  #     end
  #     it '編集リンクが表示される' do
  #       expect(page).to have_link '編集', href: edit_course_path(course)
  #     end
  #     it '削除リンクが表示される' do
  #       expect(page).to have_link '削除' , href: course_path(course)
  #     end
  #   end

  #   context '削除リンクのテスト' do
  #     before do
  #       click_link '削除'
  #     end

  #     it '正しく削除される' do
  #       expect(Course.where(id: course.id).count).to eq 0
  #     end

  #     it 'リダイレクト先がユーザー詳細画面になっている' do
  #       expect(current_path).to eq '/users/' + user.id.to_s
  #     end
  #   end

  #   context '編集リンクのテスト' do
  #     it '自分の編集画面に遷移する' do
  #       click_link '編集'
  #       expect(current_path).to eq '/courses/' + course.id.to_s + '/edit'
  #     end
  #   end

  #   context '他のユーザーの編集画面に遷移' do
  #     it '遷移できない' do
  #       visit edit_course_path(other_course)
  #       expect(current_path).to eq '/users/' + user.id.to_s
  #     end
  #   end
  # end

  describe '自分の投稿の編集画面のテスト' do
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

    context '編集成功のテスト' do
      before do
        @course_old_title = course.title
        @course_old_distance = course.distance
        @course_old_description = course.description
        fill_in 'course[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'course[distance]', with: Faker::Lorem.characters(number: 5)
        fill_in 'course[description]', with: Faker::Lorem.characters(number: 5)
        click_button "変更を保存"
      end

      it 'titleが正しく更新される' do
        expect(course.reload.title).not_to eq @course_old_title
      end
      it 'distanceが正しく更新される' do
        expect(course.reload.distance).not_to eq @course_old_distance
      end
      it 'descriptionが正しく更新される' do
        expect(course.reload.description).not_to eq @course_old_description
      end

    end
  end
end