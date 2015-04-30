require 'rails_helper'

RSpec.describe AudioMetadata, :type => :model do
  context 'AudioMetadata Class' do
    it "Should not use a prefix" do
      expect(AudioMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(AudioMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
