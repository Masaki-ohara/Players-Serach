# class Prediction < ApplicationRecord
#   belongs_to :user
#   belongs_to :match

#   validates :home_score, presence: true
#   validates :away_score, presence: true
#   validates :predicted_winner, presence: true
#   validates :predicted_loser, presence: true
#   validates :user_id, presence: true
#   validates :match_id, presence: true

#   #カスタムバリデーション
#   validate :test
#    def test
#     if draw == "1"
#       if home_score != away_score
#         errors.add(:base, 'スコアが一致していません')
#       end
#       if predicted_winner != predicted_loser
#         errors.add(:base, '一致していません')
#       end
#     end
#    end
#    validates :draw, inclusion: { in: [true, false] }
# end
# class Prediction < ApplicationRecord
#   belongs_to :user
#   belongs_to :match

#   validates :home_score, presence: true
#   validates :away_score, presence: true
#   validates :user_id, presence: true
#   validates :match_id, presence: true

#   #カスタムバリデーション
#   validate :test

#   def test
#     if draw == "1"
#       if home_score != away_score
#         errors.add(:base, 'スコアが一致していません')
#       end
#     else
#       validates :predicted_winner, presence: true
#       validates :predicted_loser, presence: true
#     end
#   end
# end
# class Prediction < ApplicationRecord
#   belongs_to :user
#   belongs_to :match

#   validates :home_score, presence: true
#   validates :away_score, presence: true
#   validates :user_id, presence: true
#   validates :match_id, presence: true


#   #カスタムバリデーション
#   validate :test

# def test
#   if draw == "1"
#     if home_score != away_score
#       errors.add(:base, 'スコアが一致していません')
#     end
#   else
#     if predicted_winner.blank? || predicted_loser.blank?
#       errors.add(:base, '勝者と敗者を選択してください')
#     end
#   end
# end
# end


#   def test
#     if draw == "1"
#       if home_score != away_score
#         errors.add(:base, 'スコアが一致していません')
#       end
#     else
#       validates :predicted_winner, presence: true
#       validates :predicted_loser, presence: true      
#     end
#   end
# end

class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :home_score, presence: true
  validates :away_score, presence: true
  validates :user_id, presence: true
  validates :match_id, presence: true

  has_many :comments, dependent: :destroy

  # カスタムバリデーション
  validate :test

  before_save :set_predictions
  
  def set_predictions
    if draw == "1"
      self.draw = "⚪︎"
    else
      self.draw = "✖️"
    end
  end

  def test
    if draw == "1"
      if home_score != away_score
        errors.add(:base, 'スコアを同点にしてください')
      end
    else
      if predicted_winner.present? && predicted_loser.present? && predicted_winner == predicted_loser
        errors.add(:base, '勝者と敗者は同じチームを選択できません')
      end
    end
  end
end
