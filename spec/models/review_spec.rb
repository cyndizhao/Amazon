require 'rails_helper'

RSpec.describe Review, type: :model do
  def valid_attributes(new_attributes ={}){
    body: 'you are awesome',
    rating: 5
  }.merge(new_attributes)
  end
  describe "Valication" do
    it 'requires a rating' do
      review = Review.new(valid_attributes({rating: nil}))
      expect(review).to be_invalid
    end

    it 'is a number between 1 and 5' do
      review = Review.new(valid_attributes({rating: 6}))
      expect(review).to be_invalid
    end
  end
end
