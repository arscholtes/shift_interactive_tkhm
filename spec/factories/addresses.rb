# spec/factories/addresses.rb
require 'faker'

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    suite { Faker::Address.secondary_address }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip_code }
    user
  end
end
