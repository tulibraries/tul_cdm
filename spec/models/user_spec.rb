require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "Class" do
    subject { User.new() }

    it { is_expected.to have_attribute(:email) }
    it { is_expected.to have_attribute(:encrypted_password) }
  end

  describe "Object" do
    let (:u) { FactoryGirl.build(:user) }
    
    it "is expected to be stringfied as its email" do
      expect(u.to_s).to eq(u.email)
    end
  end

end
