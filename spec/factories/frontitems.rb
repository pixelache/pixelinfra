# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :frontitem do
    item_type "MyString"
    item_id 1
    position 1
    external_url "MyString"
    background_colour "MyString"
    text_colour "MyString"
    active false
    frontmodule_id 1
  end
end
