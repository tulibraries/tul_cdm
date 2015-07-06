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

end
