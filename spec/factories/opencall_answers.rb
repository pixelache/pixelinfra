FactoryGirl.define do
  factory :opencall_answer do
    opencallsubmission nil
opencallquestion nil
answer "MyText"
attachment_file_name "MyString"
attachment_file_size 1
attachment_content_type "MyString"
  end

end
