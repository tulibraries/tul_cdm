class AddIpAccessToDigitalCollection < ActiveRecord::Migration
  def change
    add_column :digital_collections, :is_private, :boolean
    add_column :digital_collections, :allowed_ip_addresses, :string
  end
end
