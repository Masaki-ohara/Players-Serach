class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :league, null: false
      t.integer :season

      t.timestamps
    end
  end
end
