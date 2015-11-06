require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DigitalCollectionsHelper.

RSpec.describe DigitalCollectionsHelper, :type => :helper do

  let (:digital_collection) { FactoryGirl.create(:digital_collection) }
  let (:collection_path) { "/?f[digital_collection_sim][]=#{digital_collection.name}"}
  let (:collection_id) { digital_collection.collection_alias }

  it "creates a link to a blacklight collection" do
    expect(path(digital_collection)).to eq(collection_path)
  end

  it "gets the collection_name from the collection_alias" do
    expect(name(collection_id)).to eq(digital_collection.name)
  end

  it "gets the collection_image from the collection_alias" do
    expect(image(collection_id)).to eq(digital_collection.image_url)
  end

  it "gets the collection_thumbnail from the collection_alias" do
    expect(thumbnail(collection_id)).to eq(digital_collection.thumbnail_url)
  end

  it "gets the collection_description from the collection_alias" do
    expect(description(collection_id)).to eq(digital_collection.description)
  end

  it "gets the collection_short_description from the collection_alias" do
    expect(short_description(collection_id)).to eq(digital_collection.short_description)
  end

  context "Proxy URL Prefix" do
    let (:proxy_collection) { FactoryGirl.create(:proxy_collection) }
    let (:proxy_collection_path) { "?f[digital_collection_sim][]=#{proxy_collection.name}"}
    let (:host) { "http://example.com" }

    it "gets the collection_proxy_url_prefix from the collection_alias" do
      expect(proxy_url_prefix(proxy_collection.collection_alias)).to eq(proxy_collection.proxy_url_prefix)
    end

    it "gets the proxy prefixed to the landing page" do
      proxy_landing_page = proxy_collection.proxy_url_prefix
      proxy_landing_page += [host, proxy_collection.collection_alias, proxy_collection_path].join('/')
      expect(landing_page(host, proxy_collection)).to eq(proxy_landing_page)
    end
  end

end
