# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    user nil
    year "MyString"
    paid false
    hallitus false
    hallitus_alternate false
  end
end
