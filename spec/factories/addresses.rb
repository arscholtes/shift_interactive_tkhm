FactoryBot.define do
  factory :address do
    street { "Main St" }
    suite { "321"}
    city { "Chicago" }
    zipcode { "60504" }
    user
  end
end
