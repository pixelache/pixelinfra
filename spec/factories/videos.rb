# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title "MyString"
    description "MyText"
    url "MyString"
    hostid "MyString"
    thumbnail "MyString"
    thumbnail__size 1
    thumbnail_width 1
    thumbnail_height 1
    thumbnail_content_type "MyString"
    event nil
    project nil
    festival nil
    video_width 1
    video_height 1
    duration 1
    published false
  end
end
