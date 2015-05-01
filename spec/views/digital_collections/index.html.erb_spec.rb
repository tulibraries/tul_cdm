require 'rails_helper'

RSpec.describe "digital_collections/index", :type => :view do
  before(:each) do
    assign(:digital_collections, [
      DigitalCollection.create!(
        :collection_alias => "Alias1",
        :name => "Name",
        :image_url => "image_url.png",
        :thumbnail_url => "thumbnail_url.png",
        :priority => 1,
        :description => "MyText"
      ),
      DigitalCollection.create!(
        :collection_alias => "Alias2",
        :name => "Name",
        :image_url => "image_url.png",
        :thumbnail_url => "thumbnail_url.png",
        :priority => 2,
        :description => "MyText"
      )
    ])

    sign_in FactoryGirl.create(:user)

  end

  xit "renders a list of digital_collections" do
    assert_select "tr>td", :text => "Alias1".to_s, :count => 1
    assert_select "tr>td", :text => "Alias2".to_s, :count => 1
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "image_url.png".to_s, :count => 2
    assert_select "tr>td", :text => "thumbnail_url.png".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "a[href='#{collection_1_url}']", :count => 2
    assert_select "a[href='#{collection_2_url}']", :count => 2
  end
end
