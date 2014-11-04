# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    item nil
    user nil
    content "MyText"
    image "MyString"
    image_width 1
    image_content_type "MyString"
    image_size 1
    image_height 1
    attachment "MyString"
    attachment_size 1
    attachment_content_type "MyString"
  end
end
