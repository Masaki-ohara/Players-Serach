class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prediction
  belongs_to :match

  validates :user_id, presence: true
  validates :match_id, presence: true
  validates :prediction_id, presence: true
  validates :content, presence: true
end
