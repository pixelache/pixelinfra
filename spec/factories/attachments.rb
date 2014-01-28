# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    attachedfile "MyString"
    attachedfile_content_type "MyString"
    attachedfile_size 1
    title "MyString"
    description "MyText"
    public false
  end
end
