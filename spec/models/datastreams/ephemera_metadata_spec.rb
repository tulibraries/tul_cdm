require 'rails_helper'

RSpec.describe EphemeraMetadata, :type => :model do
  context 'EphemeraMetadata Class' do
    it "Should not use a prefix" do
      expect(EphemeraMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(EphemeraMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
