class AddPredictedWinnerToPredictions < ActiveRecord::Migration[6.1]
  def change
    add_column :predictions, :predicted_winner, :string
    add_column :predictions, :comment, :string
    add_column :predictions, :draw, :string
    #:boolean default: false
  end
end
