class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :player_name
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
