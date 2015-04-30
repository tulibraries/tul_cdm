class AddCustomUrlToDigitalCollection < ActiveRecord::Migration
  def change
    add_column :digital_collections, :custom_url, :string
    add_column :digital_collections, :is_custom_landing_page, :boolean
  end
end
