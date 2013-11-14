# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :subsite do |f|
    f.name { Faker::Company.name }
    f.description { Faker::Company.catch_phrase }
    f.subdomain { Faker::Internet.user_name }
  end
end
