# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :etherpad do
    name "MyString"
    read_only_id "MyString"
    deleted false
    last_edited "2013-12-15 20:40:26"
  end
end
