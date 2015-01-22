class DigitalCollection < ActiveRecord::Base
  validates :collection_alias, presence: true, uniqueness: true
end
