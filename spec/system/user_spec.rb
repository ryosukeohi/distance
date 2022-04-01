require 'rails_helper'

RSpec.describe '投稿のテスト', type: :system do
  before do
   @user = FactoryBot.create(:user)
  end
  describe "ユーザー新規登録" do
    it "ユーザー新規登録ができるか" do
      visit root_path
      click_on "新規登録"
      fill_in "Name", with: @user.name
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      fill_in "Password confirmation", with: @user.password
      click_on "Sign up"
      expect(current_path).to eq('/courses')
    end
  end
  describe "記録投稿" do
    before do
      @record = FactoryBot.create(:record, user_id: @user.id)
      sign_in @user
    end
    context "正常に記録を投稿できるか" do
      it "投稿詳細に遷移するか" do
        visit user_path(@user)
        click_on "記録投稿"
        fill_in "inputDescription", with: @record.description
        fill_in "inputDistance", with: @record.distance
        select "日付", from: "inputDate"
        click_on "投稿"
        expect(current_path).to eq('/records/' + @record.id.to_s)
       end
    end
  end
end