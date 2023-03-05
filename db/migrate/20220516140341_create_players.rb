class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :player_name
      t.string :team
      t.integer :season
      t.integer :age
      t.integer :league, null: false
      t.string :image_url, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
