require 'rails_helper'

RSpec.describe SheetmusicMetadata, :type => :model do
  context 'SheetmusicMetadata Class' do
    it "Should not use a prefix" do
      expect(SheetmusicMetadata.new.prefix).to be_blank
    end

    it "Should have no fields" do
      expect(SheetmusicMetadata.xml_template.children[0].children.count).to eq 0
    end

  end
end
