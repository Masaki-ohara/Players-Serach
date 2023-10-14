class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :home_team_name
      t.string :away_team_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
