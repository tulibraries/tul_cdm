require 'rails_helper'

RSpec.describe "digital_collections/new", :type => :view do
  before(:each) do
    assign(:digital_collection, DigitalCollection.new(
      :collection_alias => "MyString",
      :name => "MyString",
      :image_url => "MyString",
      :thumbnail_url => "MyString",
      :description => "MyText",
      :priority => "0",
      :is_private => true,
      :allowed_ip_addresses => "192.168.1.1, 128.0.0.1"
    ))
  end

  it "renders new digital_collection form" do
    render

    assert_select "form[action=?][method=?]", digital_collections_path, "post" do

      assert_select "input#digital_collection_collection_alias[name=?]", "digital_collection[collection_alias]"

      assert_select "input#digital_collection_name[name=?]", "digital_collection[name]"

      assert_select "input#digital_collection_image_url[name=?]", "digital_collection[image_url]"

      assert_select "input#digital_collection_thumbnail_url[name=?]", "digital_collection[thumbnail_url]"

      assert_select "textarea#digital_collection_description[name=?]", "digital_collection[description]"

      assert_select "input#digital_collection_priority[name=?]", "digital_collection[priority]"

      assert_select "input#digital_collection_is_private[name=?]", "digital_collection[is_private]"

      assert_select "input#digital_collection_allowed_ip_addresses[name=?]", "digital_collection[allowed_ip_addresses]"
    end
  end
end
