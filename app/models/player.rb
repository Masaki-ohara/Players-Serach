class Player < ApplicationRecord
  include ActiveModel::Model
  #has_many favorites, dependent: :destroy   
  #belongs_to :user

  attr_accessor :player_name, :season, :league
  
  validates :player_name, presence: true
  validates :season, presence: true
  validates :league, presence: true
  # player = Player.search(params[:keyword])
  # def favorited_by?(user)
  #   favorites.where(user_id: user.id).exists?
  # end
end

