# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    source_url { Faker::Internet.url }
    tags { Faker::Internet.slug }
    description { Faker::Lorem.paragraph }
  end
end
