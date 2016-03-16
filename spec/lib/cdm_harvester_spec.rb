require 'rails_helper'
require 'cdm_harvester'

RSpec.describe HarvestedCollection do

  let (:collection) { FactoryGirl.build(:harvested_collection) }
  let (:first_pid) { collection.xml_objects.keys.first }
  let (:last_pid) { collection.xml_objects.keys.last }

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

  describe "Shows Harvested Collection items" do

    it "shows first objects" do
      expect(subject.xml_objects[first_pid]).to eq(collection.xml_objects[first_pid])
    end

    it "shows last objects" do
      expect(subject.xml_objects[last_pid]).to eq(collection.xml_objects[last_pid])
    end

  end

  describe "Delete Harvested Collection Item" do

    it "deletes an xml objects" do
      expect(subject.xml_objects[first_pid]).to be
      subject.xml_objects.delete(first_pid)
      expect(subject.xml_objects[first_pid]).to_not be
    end

    it "deletes another xml objects" do
      expect(subject.xml_objects[last_pid]).to be
      subject.xml_objects.delete(last_pid)
      expect(subject.xml_objects[last_pid]).to_not be
    end

  end
end
