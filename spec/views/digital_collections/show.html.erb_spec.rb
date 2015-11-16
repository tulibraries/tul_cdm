require 'rails_helper'

RSpec.describe "digital_collections/show", :type => :view do
  context "Normal digital colleciton" do
    before(:each) do
      @digital_collection = assign(:digital_collection, DigitalCollection.create!(
        :collection_alias => "Collection Alias",
        :name => "Name",
        :image_url => "ImageUrl.png",
        :thumbnail_url => "ThumbnailUrl.png",
        :description => "MyText"
      ))
    end

    it "renders attributes in <p>" do
      render
      expect(rendered).to match(/Name/)
      expect(rendered).to match(/ImageUrl.png/)
      expect(rendered).to match(/ThumbnailUrl.png/)
      expect(rendered).to match(/MyText/)
    end
  end

  context "Proxy collection" do
    let (:test_prefix) { "http://libproxy.temple.edu/login?url=" }
    before(:each) do
      @digital_collection = assign(:digital_collection, DigitalCollection.create!(
        :collection_alias => "Proxy Alias",
        :name => "proxy_collection",
        :image_url => "ImageUrl.png",
        :thumbnail_url => "ThumbnailUrl.png",
        :description => "MyText",
        :proxy_url_prefix => test_prefix
      ))
    end

    it "renders the digital proxy" do
      render
      full_path = collection_url(@digital_collection)
      expect(rendered).to include(full_path)
    end
  end
end
