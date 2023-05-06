class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :player_id
      t.timestamps
      #add_index :favorites, [:user_id, :player_id], unique: true
    end
  end
end
