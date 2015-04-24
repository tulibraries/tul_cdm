require 'rails_helper'

RSpec.describe CollectionMetadata, :type => :model do
  context 'CollectionMetadata Class' do
    it "Should not use a prefix" do
      expect(CollectionMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(CollectionMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
