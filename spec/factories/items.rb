# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    source_url { Faker::Internet.url }
    tag_list { [Faker::Internet.slug] }
    description { Faker::Lorem.paragraph }
    location

    trait :for_params do
      tag_list { [Faker::Internet.slug].map { |tag| { value: tag } }.to_json }
    end
  end
end
