# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 10) }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 20) }
    user_token { association :user_token, strategy: :build }
  end
end
