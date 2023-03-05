class Player < ApplicationRecord
  belongs_to :user

  has_many :season
  validates :player_name, presence: true
  validates :season, presence: true
end

