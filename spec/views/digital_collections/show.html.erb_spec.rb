require 'rails_helper'

RSpec.describe "digital_collections/show", :type => :view do
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
    expect(rendered).to match(/Collection Alias/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/ImageUrl.png/)
    expect(rendered).to match(/ThumbnailUrl.png/)
    expect(rendered).to match(/MyText/)
  end
end
