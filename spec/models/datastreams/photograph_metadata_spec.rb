require 'rails_helper'

RSpec.describe PhotographMetadata, :type => :model do
  context 'PhotographMetadata Class' do
    it "Should not use a prefix" do
      expect(PhotographMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(PhotographMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
