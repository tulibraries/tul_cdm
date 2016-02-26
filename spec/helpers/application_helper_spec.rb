require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, :type => :helper do
  describe "#render_with_contentdm_collection_name" do
    let (:digital_collection) { FactoryGirl.create(:digital_collection) }
    let (:collection_alias) { digital_collection.collection_alias }
    let (:collection_name) { digital_collection.name }
    let (:bogus_collection_name) { "BADDECAF" }

    it "returns the collection name when given the alias" do
      expect(render_with_contentdm_collection_name(collection_alias)).to match(/#{collection_name}/)
    end

    it "returns the alias when given the alias not in digital collection" do
      expect(render_with_contentdm_collection_name(bogus_collection_name)).to match(/#{bogus_collection_name}/)
    end
  end

  xdescribe "#show_document_title" do
    describe "Non video document" do
      let (:manuscript) { FactoryGirl.create(:manuscript); }
      it "returns the object's title if the object is a manuscript" do
        expect(show_document_title(manuscript.to_solr)).to eq(manuscript.title.first)
      end
    end

    describe "Video document" do
      let (:video) { FactoryGirl.create(:video) }
      it "returns the object's clip_title if the object is a video" do
        expect(show_document_title(video.to_solr)).to eq(video.clip_title.first)
      end
    end
  end
end
