require 'rails_helper'

RSpec.describe PosterMetadata, :type => :model do
  context 'PosterMetadata Class' do
    it "Should not use a prefix" do
      expect(PosterMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(PosterMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
