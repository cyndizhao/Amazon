class Product < ApplicationRecord
  validates(:title, { presence: true, uniqueness: true, exclusion: { in: %w( Apple Software Sony),message: "%{value} is reserved." }})
  #validates the title to be true, unique and not the reserved words
  validates(:price, { presence: true, numericality: { greater_than_or_equal_to: 0 }})
  validates(:description, {presence: true})
  validates(:sale_price, { presence:true, numericality: { less_than_or_equal_to: :price}})

  validate :description_length

  after_initialize :set_defaults
  before_validation :capitalize_title


  def self.search(arg1, arg2)
    where(["title ILIKE ? OR description ILIKE ?", "%#{arg1}%", "%#{arg2}%"]).order(:description, :title)
    # (['description ILIKE ?', "%#{arg2}%"], ['title ILIKE ?', "%#{arg2}%"])

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
