# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flickrset do
    flickr_id 1
    title "MyString"
    description ""
    started_at "2013-12-19"
    modified_at "2013-12-19"
    event nil
    project nil
    festival nil
  end
end
