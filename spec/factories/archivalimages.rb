# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :archivalimage do
    image "MyString"
    image_size 1
    image_width 1
    image_height 1
    image_content_type "MyString"
    event nil
    festival nil
    page nil
    flickr_id 1
    project nil
    credit "MyString"
  end
end
