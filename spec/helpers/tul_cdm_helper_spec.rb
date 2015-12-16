require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DigitalCollectionsHelper.

RSpec.describe TulCdmHelper, :type => :helper do


  describe "is_allowed" do

    let (:solr_key) { 'downloadable' }
    let (:document)  { Hash.new }

    it "has a no" do
      document[solr_key] = ['No', nil]
      expect(allowed?(document, solr_key)).to_not be
    end

    it "has yes and no in any order" do
      document[solr_key] = ['Yes','No']
      expect(allowed?(document, solr_key)).to_not be
      document[solr_key] = ['No', 'Yes']
      expect(allowed?(document, solr_key)).to_not be
    end

    it "has a yes" do
      document[solr_key] = ['Yes', nil]
      expect(allowed?(document, solr_key)).to be
      document[solr_key] = [nil, 'Yes']
      expect(allowed?(document, solr_key)).to be
    end

    it "doesn't say" do
      document[solr_key] = [nil, nil]
      expect(allowed?(document, solr_key)).to_not be
    end

    it "has nothing" do
      expect(allowed?(document, solr_key)).to_not be
    end
  end

  describe "set_collection_link" do

    let (:document) { Hash.new }
    let (:digital_collection) { FactoryGirl.create(:digital_collection) }

    context "Has a landing page" do
      it "links to landing page" do
        document["contentdm_collection_id_tesim"] = [digital_collection.collection_alias]
        document["active_fedora_model_ssi"] = ""
        document["digital_collection_tesim"] = [digital_collection.name]

        expect(set_collection_link(document)).to match(/#{url_for(digital_collection)}/)
        expect(set_collection_link(document)).to match(/#{document["digital_collection_tesim"].first.gsub(" ", "%20")}/)
      end
    end

    context "Doesn't have a landing page (no digital collection record for the collection)" do

      it "links to search results" do
        document["contentdm_collection_id_tesim"] = ["COLLECTIONID"]
        document["active_fedora_model_ssi"] = ""
        document["digital_collection_tesim"] = ["A Digital Collection"]

        expect(set_collection_link(document)).to_not match(/#{url_for(digital_collection)}/)
        expect(set_collection_link(document)).to match(/#{document["digital_collection_tesim"].first.gsub(" ", "%20")}/)
      end
    end
  end

  context 'get_collection_link' do
    let (:digital_collection) {
      FactoryGirl.create(:digital_collection)
    }

    let (:document) {
      {
        "contentdm_collection_id_tesim" => [digital_collection.collection_alias],
        "active_fedora_model_ssi" => "",
        "digital_collection_tesim" => [digital_collection.name]
      }
    }

    it "links to the digital collection" do
      expect(get_collection_link(document)).to match(/#{url_for(digital_collection)}\/\?f\[digital_collection_sim\]\[\]=#{document["digital_collection_tesim"].first.gsub(" ", "%20")}/)
    end

    it "does not links to the digital collection" do
      document["active_fedora_model_ssi"] = "Collection"
      expect(get_collection_link(document)).to be_nil
    end
  end

  context 'render_related_resources' do
    let (:document) { Hash.new }
    let (:digital_collection) { FactoryGirl.create(:digital_collection) }

    it "links to the digital collection" do
      document["contentdm_collection_id_tesim"] = [digital_collection.collection_alias]
      document["active_fedora_model_ssi"] = ""
      document["digital_collection_tesim"] = [digital_collection.name]
      rendered_related_resources = render_related_resources(document)

      expect(rendered_related_resources).to match(/#{digital_collection.name}/)
      expect(rendered_related_resources).to match(/#{document["digital_collection_tesim"].first.gsub(" ", "%20")}/)
    end
  end

end
