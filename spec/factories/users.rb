# spec/factories/users.rb
require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.cell_phone }
    company_name { Faker::Company.name }
  end
end
