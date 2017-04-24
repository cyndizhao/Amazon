class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates :body, presence: true
  validates(:rating, { presence: true, inclusion: {in: 1..5}})
  #inclusion: 1..5

  def votes_count
    # TODO: attempt to do it in a single query
    votes.where(is_up: true).count - votes.where(is_up: false).count
  end
  
  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by(user: user)
  end
end
