class Player < ApplicationRecord
  include ActiveModel::Model
  #belongs_to :user

  attr_accessor :player_name, :season, :league
  
  validates :player_name, presence: true
  validates :season, presence: true
  validates :league, presence: true
end

