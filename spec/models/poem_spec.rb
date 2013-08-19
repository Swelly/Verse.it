# spec/models/contact.rb
require 'spec_helper'

describe Poem do

  it "has a valid factory" do
    FactoryGirl.create(:poem).should be_valid
  end

  it "is invalid without text" do
    FactoryGirl.build(:poem, text: "").should_not be_valid
  end

  it { should belong_to(:user) }

  it "is invalid without a source user" do
    FactoryGirl.build(:poem, source_user: "").should_not be_valid
  end

end