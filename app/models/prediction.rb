class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :home_score, presence: true
  validates :away_score, presence: true
  validates :predicted_winner, presence: true
  validates :predicted_loser, presence: true
  validates :user_id, presence: true
  validates :match_id, presence: true

  #カスタムバリデーション
  validate :test
   def test
    if draw == "1"
      if home_score != away_score
        errors.add(:base, 'スコアが一致していません')
      end
      if predicted_winner != predicted_loser
        errors.add(:base, '一致していません')
      end
    end
   end
  # validates :draw, inclusion: { in: [true, false] }
end
