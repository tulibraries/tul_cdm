class AddColumnToDigitalCollection < ActiveRecord::Migration
  def change
    add_column :digital_collections, :priority, :integer
  end
end
