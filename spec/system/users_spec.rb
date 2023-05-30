require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Players", type: :system do
  let(:user) { create(:user) }
  describe 'ユーザーの新規登録' do
    it 'ユーザの登録' do
      visit  new_user_path
      fill_in '名前', with: 'user'
      fill_in 'メールアドレス', with: 'user@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button '登録'
      expect(current_path).to eq('/login')
      expect(page).to have_content('ログイン')
    end

    it '1-2:同じメールアドレスのユーザーは新規登録できない' do
        # user = create(:user)
        visit new_user_path
        fill_in '名前', with: 'user'
        fill_in 'メールアドレス', with: 'user@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認用)', with: 'password'
        click_button '登録'
        expect(current_path).to eq  login_path
        expect(page).to have_content('登録')
        expect(page).to have_content('ユーザーの作成に失敗しました')
    end

    it '1-3:パスワードが3文字未満の場合に新規登録できない' do
        visit new_user_path
        fill_in '名前', with: 'user'
        fill_in 'メールアドレス', with: 'user@example.com'
        fill_in 'パスワード', with: 'pa'
        fill_in 'パスワード(確認用)', with: 'pa'
        click_button '登録'
        expect(current_path).to eq users_path
        expect(page).to have_content('登録')
        expect(page).to have_content('ユーザーの作成に失敗しました')
    end
  end
end




