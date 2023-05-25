require 'rails_helper'

RSpec.describe "Players", type: :system do
  describe '検索機能' do
    it '検索ページが表示されること' do
      visit players_search_path
      click_link "選手を検索"
      fill_in "league", with: ""
      fill_im "season," with: ""
      fill_im "player_name" with: ""
      click button "検索する"