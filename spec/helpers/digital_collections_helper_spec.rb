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
end
