class CreatePredictions < ActiveRecord::Migration[5.2]
  def change
    unless table_exists?(:predictions)
      create_table :predictions do |t|
        t.integer :user_id
        t.integer :match_id
        t.string :predicted_winner
  
        t.timestamps
        # Define your columns here
      end
    end
  end
end
