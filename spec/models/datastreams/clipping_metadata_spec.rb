require 'rails_helper'

RSpec.describe ClippingMetadata, :type => :model do
  context 'ClippingMetadata Class' do
    it "Should not use a prefix" do
      expect(ClippingMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(ClippingMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
