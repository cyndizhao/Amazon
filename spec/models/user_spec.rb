require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_attributes(new_attributes = {})
    { first_name: 'John',
      last_name:  'Smith',
      email:      'john@smith.com',
      password:   'supersecret'
   }.merge(new_attributes)
  end
  describe 'Validations' do

    it 'requires a first name' do
      #test here
      user = User.new(valid_attributes({first_name:nil}))
      expect(user).to be_invalid
    end
    it 'requires a last name' do
      #test here
      user = User.new(valid_attributes({last_name:nil}))
      expect(user).to be_invalid
    end
    it 'requires an email' do
      #
      user = User.new(valid_attributes({email:nil}))
      expect(user).to be_invalid
    end
    it 'requires an unique email' do
      #
      user1 = User.create(valid_attributes)
      user2 = User.create(valid_attributes)
      expect(user2.errors.messages).to have_key(:email)
      #also work!!!!!
      # user1 = FactoryGirl.create(:user)
      # user2 = User.new(valid_attributes({email: user1.email}))
      # expect(user2).to be_invalid
    end
  end
  describe 'full name method' do
    it 'return the first_name and last_name concatenated and titleized' do
      john_smith = "John Smith"
      user = User.new(valid_attributes)
      expect(user.full_name).to eq(john_smith)
    end
  end
end
