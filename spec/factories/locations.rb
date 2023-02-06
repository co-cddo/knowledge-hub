FactoryBot.define do
  factory :location do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    tag_list { [Faker::Internet.slug] }

    trait :for_params do
      tag_list { [Faker::Internet.slug].map { |tag| { value: tag } }.to_json }
    end
  end
end
