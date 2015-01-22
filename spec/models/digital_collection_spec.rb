require 'rails_helper'

RSpec.describe DigitalCollection, :type => :model do

  describe "Class" do
    subject { FactoryGirl.build(:digital_collection) }

    it { is_expected.to have_attribute(:collection_alias) }
    it { is_expected.to have_attribute(:name) }
    it { is_expected.to have_attribute(:thumbnail_url) }
    it { is_expected.to have_attribute(:description) }
  end

  describe "Object" do

    context "Valid object" do
      subject { FactoryGirl.build(:digital_collection) }
      it { is_expected.to be_valid }
    end

    context "Invalid object" do
      it "Must have a collection alias" do
        expect(DigitalCollection.new()).to_not be_valid
      end

      it "Must not have a nil collection alias" do
        expect(DigitalCollection.new(collection_alias: nil)).to be_valid
      end

      it "Must be a unique collection" do
        expect(DigitalCollection.create(collection_alias: "p1234")).to be_valid
        expect(DigitalCollection.create(collection_alias: "p1234")).to_not be_valid
      end
    end

  end

end
