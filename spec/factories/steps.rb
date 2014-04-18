# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :step do
    subsite nil
    festival nil
    node nil
    start_at "2014-04-18"
    end_at "2014-04-18"
    name "MyString"
    event nil
    slug "MyString"
  end
end
