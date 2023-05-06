class Favorite < ApplicationRecord
  belongs_to :user
  # belongs_to :player

  validates :user_id, uniqueness: { scope: :player_id }
  # def favorited_by?(user)
  #   favorite.where(user_id: user_id).exists?
  # end
end
