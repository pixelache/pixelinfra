# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    filename "MyString"
    filename_width 1
    filename_height 1
    filename_content_type "MyString"
    filename_size 1
  end
end
