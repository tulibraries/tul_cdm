class DigitalCollection < ActiveRecord::Base
  validates :collection_alias, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :collection_alias, use: [:slugged, :finders]

  def conform_attributes
    string_columns = [:allowed_ip_addresses, :custom_url]
    string_columns.each do |column|
      self[column] = self[column].to_s
    end
  end
end
