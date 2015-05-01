require 'rails_helper'

RSpec.describe CollectionController, :type => :controller do
  let (:collection) {"p15037coll10"}
  let (:collectionController) {CollectionController.new}

  it "render title" do
    expect(collectionController.render_title(collection)).to match(/#{collection}/)
  end

  describe "render blurb" do
    subject {collectionController.render_blurb(collection)}
    xit { is_expected.to respond_to(:title) }
  end

  describe "render image grid" do
    let (:grid_output) {"Here: changeme:1 || <br /> Here: changeme:2 ||".html_safe}

    it "renders an image grid" do
      allow(collectionController).to receive(:create_image_grid).with(collection) { grid_output }
      expect(collectionController.render_image_grid).to match(/changeme:1/)
      expect(collectionController.render_image_grid).to match(/changeme:2/)
    end
  end

  describe "create image grid" do
    context "of only one row" do
      let (:feature_path) {"#{Rails.root}/app/controllers/featured/#{collection}_featured.xml"}
      let (:xml_output) {<<-END_XML.gsub(/^ {6}/, '')
        <featured_objects>
          <object>
            <pid>changeme:1</pid>
            <path_to_thumbnail>http://example.com/thumbnail1.jpg</path_to_thumbnail>
          </object>
          <object>
            <pid>changeme:2</pid>
            <path_to_thumbnail>http://example.com/thumbnail2.jpg</path_to_thumbnail>
          </object>
        </featured_objects>
        END_XML
        }
      it "creates a one row image grid" do
        allow(collectionController).to receive(:open).with(feature_path) { xml_output }
        expect(collectionController.render_image_grid(collection)).to match(/changeme:1/)
        expect(collectionController.render_image_grid(collection)).to match(/changeme:2/)
        expect(collectionController.render_image_grid(collection)).to_not match(/\<br \/\>/)
      end
    end
    context "that spans more than one row" do
      let (:feature_path) {"#{Rails.root}/app/controllers/featured/#{collection}_featured.xml"}
      let (:xml_output) {<<-END.gsub(/^ {8}/, '')
        <featured_objects>
          <object>
            <pid>changeme:1</pid>
            <path_to_thumbnail>http://example.com/thumbnail1.jpg</path_to_thumbnail>
          </object>
          <object>
            <pid>changeme:2</pid>
            <path_to_thumbnail>http://example.com/thumbnail1.jpg</path_to_thumbnail>
          </object>
          <object>
            <pid>changeme:3</pid>
            <path_to_thumbnail>http://example.com/thumbnail1.jpg</path_to_thumbnail>
          </object>
          <object>
            <pid>changeme:4</pid>
            <path_to_thumbnail>http://example.com/thumbnail1.jpg</path_to_thumbnail>
          </object>
        </featured_objects>
        END
      }
      it "creates a two row image grid" do
        allow(collectionController).to receive(:open).with(feature_path) { xml_output }
        expect(collectionController.render_image_grid(collection)).to match(/changeme:1/)
        expect(collectionController.render_image_grid(collection)).to match(/changeme:2/)
        expect(collectionController.render_image_grid(collection)).to match(/changeme:3/)
        expect(collectionController.render_image_grid(collection)).to match(/\<br \/\>/)
        expect(collectionController.render_image_grid(collection)).to match(/changeme:4/)
      end
    end
  end
end
