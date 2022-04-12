require 'rails_helper'
describe 'ログイン前のテスト' do
  describe 'ヘッダーのテスト: ログイン前' do
    before do
     visit root_path
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ヘッダーにログインリンクが表示される' do
        log_in_link = find_all('a')[2].native.inner_text
        expect(log_in_link).to match(/ログイン/)
      end
      it 'ログインリンクの内容が正しい' do
        log_in_link = find_all('a')[2].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it 'ヘッダーに新規登録リンクが表示される' do
        sign_up_link = find_all('a')[1].native.inner_text
        expect(sign_up_link).to match(/新規登録/)
      end
      it '新規登録リンクの内容が正しい' do
        sign_up_link = find_all('a')[1].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }
      it 'ログインを押すとログイン画面に遷移する' do
        login_link = find_all('a')[2].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
      it '新規登録を押すと新規登録画面に遷移する' do
        signup_link = find_all('a')[1].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/users/sign_up'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'Sign up と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in "Name", with: Faker::Lorem.characters(number: 10)
        fill_in "Email", with: Faker::Internet.email
        fill_in "Password", with: 'password'
        fill_in "Password confirmation", with: 'password'
      end
      it '正しく新規登録される' do
        expect { click_button "Sign up" }.to change(User.all, :count).by(1)
      end
      it 'リダイレクト先がコース一覧画面になっている' do
        click_button 'Sign up'
        expect(current_path).to eq '/courses'
      end
    end
  end

  describe 'ユーザーログイン' do
    let (:user) { create(:user) }
    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'Sign in と表示される' do
        expect(page).to have_content 'Sign in'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
      it 'ログイン後のリダイレクト先がコース一覧画面になっている' do
        expect(current_path).to eq '/courses'
      end
    end
  end

  describe 'ヘッダーのテスト: ログイン後' do
    let(:user) { create(:user) }
    before do
     visit new_user_session_path
     fill_in 'user[email]', with: user.email
     fill_in 'user[password]', with: user.password
     click_button 'Log in'
    end

    context 'ヘッダーの表示を確認' do
      it 'DISTANCEリンクが表示される' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(/distance/)
      end
      it 'マイページリンクが表示される' do
        my_link = find_all('a')[1].native.inner_text
        expect(my_link).to match(/マイページ/)
      end
      it 'ランキングリンクが表示される' do
        rank_link = find_all('a')[2].native.inner_text
        expect(rank_link).to match(/ランキング/)
      end
      it 'ログアウトリンクが表示される' do
        logout_link = find_all('a')[3].native.inner_text
        expect(logout_link).to match(/ログアウト/)
      end
    end
  end

  describe 'ログアウトのテスト' do
    let(:user) { create(:user) }
    before do
     visit new_user_session_path
     fill_in 'user[email]', with: user.email
     fill_in 'user[password]', with: user.password
     click_button 'Log in'
     logout_link = find_all('a')[3].native.inner_text
     logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
     click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできる: ログアウト後の画面にログインリンクがある' do
       expect(page).to have_link '', href: '/users/sign_in'
      end
      it 'ログアウト後のリダイレクト先がトップ画面になっている' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ログインしていない場合ログイン画面に遷移する' do
    let(:user) { create(:user) }
    let!(:course) { create(:course, user: user) }
    let!(:record) { create(:record, user: user) }

    subject { current_path }

    it 'ユーザー詳細画面' do
      visit user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it 'ランキング画面' do
      visit users_path
      is_expected.to eq '/users/sign_in'
    end
    it 'ユーザー編集画面' do
      visit edit_user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it '退会確認画面' do
      visit confirm_path
      is_expected.to eq '/users/sign_in'
    end
    it 'コース詳細画面' do
      visit course_path(course)
      is_expected.to eq '/users/sign_in'
    end
    it 'コース一覧画面(トップ画面)' do
      visit courses_path
      is_expected.to eq '/users/sign_in'
    end
    it 'マイコース一覧画面' do
      visit mycourse_path
      is_expected.to eq '/users/sign_in'
    end
    it 'コース投稿画面' do
      visit new_course_path
      is_expected.to eq '/users/sign_in'
    end
    it 'コース編集画面' do
      visit edit_course_path(course)
      is_expected.to eq '/users/sign_in'
    end
    it '記録詳細画面' do
      visit record_path(record)
      is_expected.to eq '/users/sign_in'
    end
    it '記録投稿画面' do
      visit new_record_path
      is_expected.to eq '/users/sign_in'
    end
    it '記録編集画面' do
      visit edit_record_path(record)
      is_expected.to eq '/users/sign_in'
    end
    it '検索結果画面' do
      visit search_path
      is_expected.to eq '/users/sign_in'
    end
  end
end