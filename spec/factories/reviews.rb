FactoryGirl.define do
  factory :review do
    body { Faker::Hipster.paragraph }
    rating { rand(1..5) }
  end
end
