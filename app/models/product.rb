class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :user_favourite_it, through: :favourites, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates(:title, { presence: true, uniqueness: true, exclusion: { in: %w( Apple Software Sony),message: "%{value} is reserved." }})
  #validates the title to be true, unique and not the reserved words
  validates(:price, { presence: true, numericality: { greater_than_or_equal_to: 0 }})
  validates(:description, {presence: true})
  validates(:sale_price, { presence:true, numericality: { less_than_or_equal_to: :price}})

  validate :description_length

  after_initialize :set_defaults
  before_validation :capitalize_title

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  mount_uploader :image, ImageUploader

  def self.search(arg1, arg2)
    where(["title ILIKE ? OR description ILIKE ?", "%#{arg1}%", "%#{arg2}%"]).order(:description, :title)
    #(['description ILIKE ?', "%#{arg2}%"], ['title ILIKE ?', "%#{arg2}%"])

  end

  def favourite_by?(user)
    favourites.exists?(user: user)
  end

  def favourite_for(user)
    favourites.find_by(user: user)
  end

  private

  def description_length
    if(description.present? && description.length < 10)
      errors.add(:description, 'description is shorter than 10 characters')
    end
  end

  def set_defaults
    self.price ||= 1
    self.sale_price ||= price
  end

  def capitalize_title
    self.title = title.capitalize if title.present?

  end

end
