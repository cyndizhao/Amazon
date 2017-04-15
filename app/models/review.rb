class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :body, presence: true
  validates(:rating, { presence: true, inclusion: {in: 1..5}})
  #inclusion: 1..5

end
