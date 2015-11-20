require 'ipaddr'

class AllowedIpAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (value.nil? || value.empty?)
      value.split(/\,\s*/).each do |address|
        begin
          IPAddr.new(address)
        rescue IPAddr::InvalidAddressError
          record.errors[:attribute] << "Not a valid Network address"
        end
      end
    end 
  end
end

class DigitalCollection < ActiveRecord::Base
  validates :collection_alias, presence: true, uniqueness: true
  validates :allowed_ip_addresses, allowed_ip_address: true
  extend FriendlyId
  friendly_id :collection_alias, use: [:slugged, :finders]
end
