require 'rails_helper'

RSpec.describe PamphletMetadata, :type => :model do
  context 'PamphletMetadata Class' do
    it "Should not use a prefix" do
      expect(PamphletMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(PamphletMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
