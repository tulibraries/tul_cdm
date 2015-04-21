class DigitalCollection < ActiveRecord::Base
  validates :collection_alias, presence: true, uniqueness: true
  extend FriendlyId
  friendly_id :collection_alias, use: [:slugged, :finders]
end
