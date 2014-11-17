# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :residency do
    name "MyString"
    country "MyString"
    start_at "2014-11-14"
    end_at "2014-11-14"
    is_micro false
    description "MyText"
    photo "MyString"
    photo_size 1
    photo_width 1
    photo_height 1
    photo_content_type "MyString"
    slug "MyString"
    project nil
  end
end
