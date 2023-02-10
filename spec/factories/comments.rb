FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    item
  end
end
