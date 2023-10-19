class AddScoresAndWinnersToPredictions < ActiveRecord::Migration[6.1]
  def change
    add_column :predictions, :home_score, :integer
    add_column :predictions, :away_score, :integer
    add_column :predictions, :predicted_loser, :string
  end
end
