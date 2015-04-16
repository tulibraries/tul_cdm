class AddFeaturedToDigitalCollections < ActiveRecord::Migration
  def change
    add_column :digital_collections, :featured, :string
  end
end
