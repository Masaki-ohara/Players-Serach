class AddFieldsToMatches < ActiveRecord::Migration[6.1]
  def change
    add_column :matches, :date, :date
    add_column :matches, :round, :integer
    add_column :matches, :league, :string
  end
end
