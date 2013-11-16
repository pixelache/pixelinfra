# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    subsite nil
    place nil
    start_at "2013-11-16 11:44:48"
    end_at "2013-11-16 11:44:48"
    published false
    image "MyString"
    image_width 1
    image_height 1
    image_content_type "MyString"
    image_size ""
    facebook_link ""
    cost 1.5
    cost_alternate 1.5
    cost_alternate_reason "MyString"
  end
end
