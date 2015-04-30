require 'rails_helper'

RSpec.describe PeriodicalMetadata, :type => :model do
  context 'PeriodicalMetadata Class' do
    it "Should not use a prefix" do
      expect(PeriodicalMetadata.new.prefix).to be_blank 
    end

    it "Should have no fields" do
      expect(PeriodicalMetadata.xml_template.children[0].children.count).to eq 0
    end
    
  end
end
