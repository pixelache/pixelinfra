# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    slug "MyString"
    subsite nil
    published false
    creator_id 1
    last_modified_id 1
    published_at "2013-11-29 21:00:16"
    wordpress_id 1
    image "MyString"
    image_width 1
    image_height 1
    image_content_type "MyString"
    image_size 1
  end
end
