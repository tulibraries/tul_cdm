require 'rails_helper'

RSpec.describe ScholarshipMetadata, :type => :model do
  context 'ScholarshipMetadata Class' do
    it "Should not use a prefix" do
      expect(ScholarshipMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(ScholarshipMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
