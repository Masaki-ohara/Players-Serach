class AddLeagueToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :league, :integer
  end
end
