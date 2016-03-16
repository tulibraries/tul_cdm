require 'rails_helper'
require 'cdm_harvester'

RSpec.describe HarvestedCollection do

  let (:collection) { FactoryGirl.build(:harvested_collection) }
  subject (:h) {
    h = HarvestedCollection.new
    h.digital_collection_id = collection.digital_collection_id
    h.xml_objects = collection.xml_objects
    h
  }
    
  describe "Create Harvested Collections" do

    it { is_expected.to have_attributes(:digital_collection_id => collection.digital_collection_id) }
    it { is_expected.to have_attributes(:xml_objects => collection.xml_objects) }

  end

  describe "Delete Harvested Collection Item" do
    it "deletes the xml objects"
  end

  describe "Delete Harvested Collection" do
    it "deletes the xml objects"
  end
end
