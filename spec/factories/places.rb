# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  factory :place do |f|
    f.name { Faker::Company.name }
    f.address1 { Faker::Address.street_address }
    f.city { Faker::Address.city }
    f.country { Faker::Address.country }
    f.postcode { Faker::Address.postcode }
    f.latitude { Faker::Address.latitude }
    f.longitude { Faker::Address.longitude }
  end
  
end
