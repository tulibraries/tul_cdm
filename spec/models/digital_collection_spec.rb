require 'rails_helper'

RSpec.describe DigitalCollection, :type => :model do

  describe "Class" do
    subject { FactoryGirl.build(:digital_collection) }

    it { is_expected.to have_attribute(:collection_alias) }
    it { is_expected.to have_attribute(:name) }
    it { is_expected.to have_attribute(:image_url) }
    it { is_expected.to have_attribute(:thumbnail_url) }
    it { is_expected.to have_attribute(:description) }
    it { is_expected.to have_attribute(:priority) }
    it { is_expected.to have_attribute(:is_private) }
    it { is_expected.to have_attribute(:allowed_ip_addresses) }
    it { is_expected.to have_attribute(:is_format_based) }
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
        expect(DigitalCollection.new(collection_alias: nil)).to_not be_valid
      end

      it "Must be a unique collection" do
        expect(DigitalCollection.create(collection_alias: "p1234")).to be_valid
        expect(DigitalCollection.create(collection_alias: "p1234")).to_not be_valid
      end
    end

    context "Restricted IP" do
      subject { FactoryGirl.build(:private_digital_collection) }

      it "Has valid IP addresses" do
        allowed_ip_addresses = subject.allowed_ip_addresses.split(%r{,\s*})
        expect(allowed_ip_addresses.length).to eq 3
        expect(allowed_ip_addresses.first).to eq "127.0.0.1"
        expect(allowed_ip_addresses.last).to eq "192.168.1.2"
      end
    end

  end

end
