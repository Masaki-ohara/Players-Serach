require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Players", type: :system do
  describe '検索機能' do
    context '検索の値が正常' do
      it '詳細ページが表示されること' do
        visit search_players_path
        # click_link "選手を検索"
        # select 'J1 League"', from: 'league'
        find("#league").find("option[value='98']").select_option
        find("#season").find("option[value='2022']").select_option
        # select '2022', from: 'season'
        fill_in "player_name", with: "Osako"
        click_button "検索"
        expect(page).to have_content('player')
        expect(current_path).to eq players_path
      end
    end
    context '検索の値が未入力' do
      it '検索が失敗する' do
        visit search_players_path
        # click_link "選手を検索"
        # select '', from: 'league'
        # select '', from: 'season'
        find("#league").find("option[value='']").select_option
        find("#season").find("option[value='']").select_option
        fill_in "player_name", with: ""
        click_button "検索"
        expect(page).to have_content('プレイヤー名を入力してください')
        expect(page).to have_content('西暦を入力してください')
        expect(page).to have_content('リーグ名を入力してください')
        expect(current_path).to eq players_path
      end
    end
  end
end


