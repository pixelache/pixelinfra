# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendee do
    user nil
    name "MyString"
    description "MyText"
    url "MyText"
    email "MyString"
    phoe "MyString"
    picture "MyString"
    picture_size 1
    picture_content_type_string "MyString"
    picture_width 1
    picture_height 1
    status false
    extra "MyText"
    country "MyString"
    attachment_url "MyString"
    address "MyText"
    organisation "MyString"
    project_name "MyString"
    project_description "MyText"
    project_creators "MyText"
    project_presenters "MyText"
    project_urls "MyText"
    motivation_statement "MyText"
    project_title "MyString"
    project_keyords "MyString"
    event nil
    slug "MyString"
  end
end
