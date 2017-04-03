require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  def valid_attributes(new_attributes)
    attributes = {
      title: "laptop",
      description: 'Cool Computer',
      price: 100
    }
    attributes.merge(new_attributes)
  end

  describe "validations" do
    context "title" do
      it 'requires a title' do
        product = Product.new(valid_attributes({title:nil}))
        expect(product).to be_invalid
      end

      it 'requires unique title' do
        product = Product.new(valid_attributes({title:'hello cyndi hi'}))

        producttest = Product.new(valid_attributes({title:'hello cyndi hi'}))
        product.save
        expect(producttest).to be_invalid
      end

      it 'capitalizes the title after getting saves' do
        product = Product.new(valid_attributes({title:'testtest'}))
        product.save
        expect(product.title).to eq('Testtest')
      end
    end

    context 'description' do
      it 'requires a description' do
        product = Product.new(valid_attributes({ description: nil }))
        expect(product).to be_invalid
      end
    end

    context 'price' do
      it 'requires a price' do
        product = Product.new(valid_attributes({price:nil}))
        expect(product).to be_invalid
      end

      it 'requires the price to be equal to greater than 0' do
        product = Product.new(valid_attributes({price: -1}))
        product.save
        expect(product.errors.messages).to have_key(:price)
      end
    end
  end
end
