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
      it 'sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end
  end
end