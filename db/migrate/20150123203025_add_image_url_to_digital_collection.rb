class AddImageUrlToDigitalCollection < ActiveRecord::Migration
  def change
    add_column :digital_collections, :image_url, :string
  end
end
