class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :is_up, inclusion:{in: [true, false]}
  validates :user_id, uniqueness: {scope: :review_id}
end
