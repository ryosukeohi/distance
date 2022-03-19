require 'rails_helper'
describe '投稿のテスト' do
  let(:record) { create(:record, description: 'hoge', distance: 'distance') }

  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
      end
    end
  end
end
