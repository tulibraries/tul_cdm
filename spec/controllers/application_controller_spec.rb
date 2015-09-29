require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  let(:private_collection) {
   FactoryGirl.build(:private_digital_collection).attributes
  }

  let(:public_collection) {
   FactoryGirl.build(:digital_collection).attributes
  }

  let(:application_controller) {
    ApplicationController.new
  }

  it "is true for a private collection" do
    expect(application_controller.is_private?(private_collection)).to be
  end

  it "is false for a public collection" do
    expect(application_controller.is_private?(public_collection)).to_not be
  end

  it "returns the private collection" do
    digital_collection = DigitalCollection.create! private_collection
    expect(application_controller.private_collections).to include(digital_collection)
  end

  it "does not returns the public collection" do
    digital_collection = DigitalCollection.create! public_collection
    expect(application_controller.private_collections).to_not include(digital_collection)
  end
end
