# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    item_type "MyString"
    item_id nil
    subsite nil
    action "MyString"
    user nil
  end
end
