# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
['Books', 'TV Shows', 'Movies', 'Clothes', 'Music', 'Food'].each do |category|
  Category.create(name: category)
end

20.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: "12345678",
              password_confirmation: "12345678"
end

20.times do
  category = Category.all.sample
  user1 = User.all.sample
  Product.create title: Faker::Hacker.say_something_smart,
                  description: Faker::Hipster.paragraph,
                  price: Faker::Commerce.price,
                  category_id: category.id,
                  user_id: user1.id
end



20.times do
  product = Product.all.sample
  user2 = User.all.sample
  Review.create body: Faker::Hipster.paragraph,
                product_id: product.id,
                user_id: user2.id,
                rating: rand(1..5)
end

puts 'Created 20 questions'
