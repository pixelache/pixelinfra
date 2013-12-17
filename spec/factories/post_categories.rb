# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post_category do
    name "MyString"
    wordpress_id 1
    slug "MyString"
  end
end
