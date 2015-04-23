class AddSlugToDigitalCollections < ActiveRecord::Migration
  def change
    add_column :digital_collections, :slug, :string
  end
end
