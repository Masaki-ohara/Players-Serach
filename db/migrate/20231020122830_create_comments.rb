class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      # t.integer :user_id
      # t.integer :match_id
      # t.integer :prediction_id
      t.references :user_id, null: false, foreign_key: true
      t.references :prediction_id, null: false, foreign_key: true
      t.references :match_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
