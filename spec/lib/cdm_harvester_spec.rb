require 'rails_helper'
require 'cdm_harvester'

RSpec.describe HarvestedCollection do
 
  describe "Add Items to a collection" do

    let (:collection) { FactoryGirl.build(:harvested_collection) }
    let (:xml_obj1) { FactoryGirl.build(:xml_object, :collection => collection.digital_collection_id) }
    let (:xml_obj2) { FactoryGirl.build(:xml_object, :collection => collection.digital_collection_id) }

    it "adds two items to a collection" do
      collection.add_object(xml_obj1)
      collection.add_object(xml_obj2)
      expect(collection.xml_objects.keys.first).to match("p16002coll1x1")
      expect(collection.xml_objects.keys.last).to match("p16002coll1x2")
    end
  end

  context 'Harvested collection with xml objects' do

    let (:collection) { FactoryGirl.build(:harvested_collection_with_xml_objects, item_count: 4) }
    let (:first_pid) { collection.xml_objects.keys.first }
    let (:last_pid) { collection.xml_objects.keys.last }

    let (:harvested) {
      h = HarvestedCollection.new
      h.digital_collection_id = collection.digital_collection_id
      h.xml_objects = collection.xml_objects
      h
    }

    describe "Read Harvested Collection items" do

      it "should have 4 objects" do
        expect(harvested.xml_objects.size).to eq 4
      end

      it "shows first objects" do
        expect(harvested.xml_objects[first_pid]).to eq(collection.xml_objects[first_pid])
      end

      it "shows last objects" do
        expect(harvested.xml_objects[last_pid]).to eq(collection.xml_objects[last_pid])
      end

    end

    describe "Delete Harvested Collection Item" do

      it "deletes an xml objects" do
        expect(harvested.xml_objects[first_pid]).to be
        harvested.delete_object(first_pid)
        expect(harvested.xml_objects[first_pid]).to_not be
      end

      it "deletes another xml objects" do
        expect(harvested.xml_objects[last_pid]).to be
        harvested.delete_object(last_pid)
        expect(harvested.xml_objects[last_pid]).to_not be
      end

    end

  end

end
