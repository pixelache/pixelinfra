require 'spec_helper'

describe Place do
  it "is invalid without a name" do
    record = FactoryGirl.build(:place, name: nil)
    I18n.available_locales.each do |locale|
      Globalize.with_locale(locale) do
        record.attribute = "Model_attribute_#{locale} #{n}"
      end
    end
    record.should_not be_valid
  end
  
  it "is invalid without both latitude and longitude" do
    FactoryGirl.build(:place, latitude: nil).should_not be_valid
    FactoryGirl.build(:place, longitude: nil).should_not be_valid
    FactoryGirl.build(:place, latitude: nil).should_not be_valid
  end
  
end
