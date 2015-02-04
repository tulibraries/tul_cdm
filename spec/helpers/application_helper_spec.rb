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
  describe "render_with_contentdm_collection_name" do
    let (:digital_collection) { FactoryGirl.create(:digital_collection) }
    let (:collection_alias) { digital_collection.collection_alias }
    let (:collection_name) { digital_collection.name }

    it "returns the collection name when given the alias" do
      expect(render_with_contentdm_collection_name(collection_alias)).to match(/#{collection_name}/)
    end
  end
end
