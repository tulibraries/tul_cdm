require 'rails_helper'

RSpec.describe DigitalCollection, :type => :model do

  describe "Class" do
    subject { FactoryGirl.build(:digital_collection) }

    it { is_expected.to have_attribute(:collection_alias) }
    it { is_expected.to have_attribute(:name) }
    it { is_expected.to have_attribute(:image_url) }
    it { is_expected.to have_attribute(:thumbnail_url) }
    it { is_expected.to have_attribute(:description) }
    it { is_expected.to have_attribute(:short_description) }
    it { is_expected.to have_attribute(:priority) }
    it { is_expected.to have_attribute(:is_private) }
    it { is_expected.to have_attribute(:allowed_ip_addresses) }
    it { is_expected.to have_attribute(:is_format_based) }
    it { is_expected.to have_attribute(:proxy_url_prefix) }
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

      describe "Has valid IP addresses" do
        subject { FactoryGirl.build(:private_digital_collection) }

        it "has the expected IP addresses" do
          allowed_ip_addresses = subject.allowed_ip_addresses.split(%r{,\s*})
          expect(allowed_ip_addresses.length).to eq 3
          expect(allowed_ip_addresses.first).to eq "127.0.0.1"
          expect(allowed_ip_addresses.last).to eq "192.168.1.2"
        end
      end

      describe "only accepts valid IP address" do
        it "accepts collection with out an allowed IP address" do
          expect(DigitalCollection.new({collection_alias: "p1234", allowed_ip_addresses: ""})).to be_valid
        end
        it "accepts collection with a valid allowed IP address" do
          expect(DigitalCollection.new({collection_alias: "p1234", allowed_ip_addresses: "1.2.3.4"})).to be_valid
        end
        it "won't accept collection with an invalid allowed IP address" do
          expect(DigitalCollection.new({collection_alias: "p1234", allowed_ip_addresses: "invalidaddress"})).to_not be_valid
        end
        it "accepts collection with a multiple allowed IP addresss" do
          expect(DigitalCollection.new({collection_alias: "p1234", allowed_ip_addresses: "1.2.3.4, 192.168.1.1"})).to be_valid
        end
        it "won't accept collection with a multiple allowed IP addresss containing an invalid address" do
          expect(DigitalCollection.new({collection_alias: "p1234", allowed_ip_addresses: "1.2.3.4, invalidaddress"})).to_not be_valid
        end
      end

    end

  end

end
