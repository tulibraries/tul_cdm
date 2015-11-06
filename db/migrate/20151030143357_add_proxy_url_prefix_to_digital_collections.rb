class AddProxyUrlPrefixToDigitalCollections < ActiveRecord::Migration
  def change
    add_column :digital_collections, :proxy_url_prefix, :string
  end
end
