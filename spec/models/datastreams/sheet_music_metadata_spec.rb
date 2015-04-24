require 'rails_helper'

RSpec.describe SheetMusicMetadata, :type => :model do
  context 'SheetMusicMetadata Class' do
    it "Should not use a prefix" do
      expect(SheetMusicMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(SheetMusicMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
