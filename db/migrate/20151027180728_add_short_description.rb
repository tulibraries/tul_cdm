class AddShortDescription < ActiveRecord::Migration
  def change
    add_column :digital_collections, :short_description, :string
  end
end
