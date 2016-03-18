require 'rails_helper'
require 'cdm_harvester'

RSpec.describe HarvestedCollection do
  
  let (:collection) { FactoryGirl.build(:harvested_collection_with_xml_objects) }
  let (:first_pid) { collection.xml_objects.keys.first }
  let (:last_pid) { collection.xml_objects.keys.last }

  subject {
    h = HarvestedCollection.new
    h.digital_collection_id = collection.digital_collection_id
    h.xml_objects = collection.xml_objects
    h
  }

  xdescribe "Verifys Harvested Collections structure" do

    it { is_expected.to have_attributes(:digital_collection_id => collection.digital_collection_id) }
    it { is_expected.to have_attributes(:xml_objects => collection.xml_objects) }

  end

  describe "Add Items to a collection" do
    let (:collection) { FactoryGirl.build(:harvested_collection) }
    it "creates a collection" do
      c = FactoryGirl.build(:xml_object, :collection => collection.digital_collection_id)
      expect(c.keys.first).to start_with('p16002coll1x').and end_with('1')
      expect(c.values.first).to match('Object 1')
    end
    it "adds several items to a collection"
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
