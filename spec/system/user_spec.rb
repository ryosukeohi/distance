require 'rails_helper'

RSpec.describe '投稿のテスト', type: :system do
  before do
   @user = FactoryBot.build(:user)
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
      @record = FactoryBot.build(:record)
    end
    context "正常に記録を投稿できるか" do
      it "投稿詳細に遷移するか" do
        click_on "マイページ"
        click_on "マイページ"
        fill_in "description", with: @course.description
        fill_in "distance", with: @course.distance
        fill_in "start_time", with: @course.start_time
        click_on "投稿"
        expect(current_path).to eq('/courses/' + @course.id.to_s)
       end
    end
  end
end