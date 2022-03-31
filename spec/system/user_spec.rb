require 'rails_helper'

Rspec.describe 'ユーザー新規登録', type: :system do
  visit root_path
  click_on "新規登録"
  fill_in "name", with: "テスト"
  fill_in "email", with: "test@test"
  fill_in "password", "111111"
  fill_in "password", "111111"
  click_on "Si"
end