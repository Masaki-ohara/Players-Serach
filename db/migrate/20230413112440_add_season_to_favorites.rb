class AddSeasonToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :season, :integer
  end
end
