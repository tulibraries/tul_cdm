require 'rails_helper'

RSpec.describe "digital_collections/show", :type => :view do
  before(:each) do
    @digital_collection = assign(:digital_collection, DigitalCollection.create!(
      :alias => "Alias",
      :name => "Name",
      :thumbnail_url => "Thumbnail Url",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Alias/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Thumbnail Url/)
    expect(rendered).to match(/MyText/)
  end
end
