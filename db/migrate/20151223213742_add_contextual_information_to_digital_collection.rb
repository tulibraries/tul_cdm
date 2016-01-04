class AddContextualInformationToDigitalCollection < ActiveRecord::Migration
  def change
    add_column :digital_collections, :finding_aid_title, :string
    add_column :digital_collections, :finding_aid_link, :string
    add_column :digital_collections, :catalog_record_title, :string
    add_column :digital_collections, :catalog_record_link, :string
  end
end
