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

    it "returns the collection name when given the alias" do
      expect(render_with_contentdm_collection_name(collection_alias)).to match(/#{collection_name}/)
    end
  end

  #NOTE: Tests do not pass because I am now hardcoding the test data won't return tesim query.
  #TODO: Compose tests that will have data that will return the desired data from the title_tesim query.
  describe "#show_document_title" do
    describe "Non video document" do
      let (:manuscript) { FactoryGirl.create(:manuscript); }
      it "returns the object's title if the object is a manuscript" do
        pending
        expect(show_document_title(manuscript)).to eq(manuscript.title.first)
      end
    end

    describe "Video document" do
      let (:video) { FactoryGirl.create(:video) }
      it "returns the object's clip_title if the object is a video" do
        pending
        expect(show_document_title(video)).to eq(video.clip_title.first)
      end
    end
  end
end
