require 'spec_helper'

describe Subsite do
  it "has a valid factory" do
    FactoryGirl.create(:subsite).should be_valid
  end
  
  it "is invalid without a name" do
    FactoryGirl.build(:subsite, name: nil).should_not be_valid
  end
  
  it "is invalid without a subdomain" do
    FactoryGirl.build(:subsite, subdomain: nil).should_not be_valid
  end
  
  # pending "add some examples to (or delete) #{__FILE__}"
end
