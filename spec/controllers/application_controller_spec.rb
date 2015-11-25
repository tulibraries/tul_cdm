require 'rails_helper'
require 'action_dispatch'

RSpec.describe ApplicationController, :type => :controller do
  let(:private_collection) {
   FactoryGirl.build(:private_digital_collection).attributes
  }

  let(:public_collection) {
   FactoryGirl.build(:digital_collection).attributes
  }

  let(:proxy_collection) {
   FactoryGirl.build(:proxy_collection).attributes
  }

  let(:application_controller) {
    ApplicationController.new
  }

  context "is_private?" do
    it "is true for a private collection" do
      expect(application_controller.is_private?(private_collection)).to be
    end

    it "is false for a public collection" do
      expect(application_controller.is_private?(public_collection)).to_not be
    end

    it "is true for a proxied colleciton" do
      expect(application_controller.is_private?(proxy_collection)).to be
    end
  end

  context "is_viewable?" do
    before :each do
      allow_message_expectations_on_nil
    end

    describe "as a public or private collection" do
      before :each do
        allow(application_controller.request).to receive(:remote_ip).and_return("0.0.0.0")
      end
      it "is viewable as public collection" do
        expect(application_controller.is_viewable?(DigitalCollection.create(public_collection))).to be
      end

      it "is not viewable as a private collection" do
        expect(application_controller.is_viewable?(DigitalCollection.create(private_collection))).to_not be
      end
    end

    describe "from an allowed ip address" do
      it "is viewable from an allowed ip address" do
        allow(application_controller.request).to receive(:remote_ip).and_return("192.168.1.2")
        expect(application_controller.is_viewable?(DigitalCollection.create(private_collection))).to be
      end
    end

    describe "as a proxied collection" do
      let(:proxy_collection) {
       FactoryGirl.build(:proxy_ip_access_collection).attributes
      }

      it "is viewable if the collection has an allowable IP address" do
        allow(application_controller.request).to receive(:remote_ip).and_return("192.168.1.1")
        expect(application_controller.is_viewable?(DigitalCollection.create(proxy_collection))).to be
      end
      it "is not viewable if it doesn't have an alloweable IP address" do
        allow(application_controller.request).to receive(:remote_ip).and_return("0.0.0.0")
        expect(application_controller.is_viewable?(DigitalCollection.create(proxy_collection))).to_not be
      end
    end

  end

  context "ip_is_allowed?" do
    describe "One individual ip address" do

      let(:private_collection) { FactoryGirl.build(:private_digital_collection_allowed).attributes }

      it "allows from accessible ip address" do
        expect(application_controller.ip_is_allowed?(private_collection, "0.0.0.0")).to be
      end
    end

    describe "list of indidviual ip addresses" do

      let(:private_collection) { FactoryGirl.build(:private_digital_collection).attributes }
      
      it "allows from accessible ip address" do
        expect(application_controller.ip_is_allowed?(private_collection, "127.0.0.1")).to be
        expect(application_controller.ip_is_allowed?(private_collection, "10.1.1.1")).to be
        expect(application_controller.ip_is_allowed?(private_collection, "192.168.1.2")).to be
      end
      it "allows from accessible ip address" do
        expect(application_controller.ip_is_allowed?(private_collection, "192.168.1.1")).to_not be
      end
    end

    describe "list of ip addresses with mask" do
     
      let(:ip_mask_collection) { FactoryGirl.build(:private_digital_collection_masked).attributes }

      it "allows from accessible ip address" do
        expect(application_controller.ip_is_allowed?(ip_mask_collection, "192.168.1.1")).to be
        expect(application_controller.ip_is_allowed?(ip_mask_collection, "192.168.1.2")).to be
      end
      it "allows from accessible ip address" do
        expect(application_controller.ip_is_allowed?(ip_mask_collection, "192.168.2.1")).to_not be
      end
    end
  end

  context "viewable_collections" do
    before :each do
      allow(application_controller.request).to receive(:remote_ip).and_return("0.0.0.0")
    end

    it "returns the viewable collection" do
      digital_collection = DigitalCollection.create! public_collection
      expect(application_controller.viewable_collections).to include(digital_collection)
    end

    it "does not returns the unviewable collection" do
      digital_collection = DigitalCollection.create! private_collection
      expect(application_controller.viewable_collections).to_not include(digital_collection)
    end
  end

  context "unviewable_collections" do
    before :each do
      allow(application_controller.request).to receive(:remote_ip).and_return("0.0.0.0")
    end

    it "returns the unviewable collection" do
      digital_collection = DigitalCollection.create! private_collection
      expect(application_controller.unviewable_collections).to include(digital_collection)
    end

    xit "doesn't return the unviewable collection with authenticated user" do
      sign_in FactoryGirl.create(:archivist_user)
      digital_collection = DigitalCollection.create! public_collection
      expect(application_controller.viewable_collections).to_not include(digital_collection)
    end

    it "doesn't return the viewable collection" do
      digital_collection = DigitalCollection.create! public_collection
      expect(application_controller.viewable_collections).to include(digital_collection)
    end
  end

  context "unviewable_by_ip_collections" do
    it "returns the viewable by ip collection"
    it "does not returns the unviewable by ip collection"
  end

  context "private_collections" do
    it "returns the private collection" do
      digital_collection = DigitalCollection.create! private_collection
      expect(application_controller.private_collections).to include(digital_collection)
    end

    it "does not returns the public collection" do
      digital_collection = DigitalCollection.create! public_collection
      expect(application_controller.private_collections).to_not include(digital_collection)
    end
  end
end
