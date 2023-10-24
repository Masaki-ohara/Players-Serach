class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :favorites, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :predictions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  def favorited_by?(player)
    #player_idを直接持ってきてる
    favorites.where(player_id: player).exists?
  end
end