require 'rails_helper'

RSpec.describe "digital_collections/index", :type => :view do
  before(:each) do
    assign(:digital_collections, [
      DigitalCollection.create!(
        :collection_alias => "Alias1",
        :name => "Name",
        :thumbnail_url => "Thumbnail Url",
        :description => "MyText"
      ),
      DigitalCollection.create!(
        :collection_alias => "Alias2",
        :name => "Name",
        :thumbnail_url => "Thumbnail Url",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of digital_collections" do
    render
    assert_select "tr>td", :text => "Alias1".to_s, :count => 1
    assert_select "tr>td", :text => "Alias2".to_s, :count => 1
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
