class AddFormatBasedCollection < ActiveRecord::Migration
  def change
    add_column :digital_collections, :is_format_based, :boolean
  end
end
