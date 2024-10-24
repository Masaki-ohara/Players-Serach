class Match < ApplicationRecord
  belongs_to :user

  validates :home_team_name, presence: true
  validates :away_team_name, presence: true
  validates :date, presence: true
  validates :round, presence: true
  validates :league, presence: true
  has_many :predictions, dependent: :destroy
  has_many :comments,  dependent: :destroy
end
