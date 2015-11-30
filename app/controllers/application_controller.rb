require 'ipaddr'

class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
   include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions.

  layout 'blacklight'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Determine if the collection is viewable depending on private flag and white-listed remote IP address
  def is_viewable? (collection)

    # If no ip address filtering
    if (collection['allowed_ip_addresses'].empty?)
      if (is_private?(collection))
        # TODO: Brittle - Allow better control over who may view a private collecionts
        RoleMapper.roles(current_user.email).include? "archivist"
      else
        true
      end
    else
      ip_is_allowed?(collection, request.remote_ip)
    end
  rescue
    # Undefined current_user method seen in testing -- current_user may throw an exception
    false
  end

  # Determine if the collection is restricted from the public
  def is_private? (collection)
    collection["is_private"] || !collection["proxy_url_prefix"].blank?
  end

  def ip_is_allowed? (collection, ip_address)

    # If none specified, then any address is allowed
    return true if collection['allowed_ip_addresses'].blank?

    # Is remote IP address in allowed address range?
    allowed = false
    test_address = IPAddr.new(ip_address)
    collection['allowed_ip_addresses'].split(/\,\s*/).each do |address|
      allowed_address = IPAddr.new(address)
      allowed = allowed_address.include?(test_address)
      if allowed
        break
      end
    end

    allowed

  end

  # Get the list of all the viewable collections depending on the private flag and white-listed remote IP address
  # Returns an ActiveRecord::Relation object just as a DigitalCollection query would
  def viewable_collections
    collections = []
    DigitalCollection.find_each { |collection| collections << collection if is_viewable?(collection) }
    # Convert the array of objects into an ActiveRecore::Relation object
    DigitalCollection.where(id: collections.map(&:id))
  end

  # Get the list of all the unviewable collections depending on the private flag and white-listed remote IP address
  # Returns an ActiveRecord::Relation object just as a DigitalCollection query would
  def unviewable_collections
    collections = []
    DigitalCollection.find_each { |collection| collections << collection unless is_viewable?(collection) }
    # Convert the array of objects into an ActiveRecore::Relation object
    DigitalCollection.where(id: collections.map(&:id))
  end

  def unallowed_by_ip_collections
    collections = []
    DigitalCollection.find_each { |collection| collections << collection unless ip_is_allowed?(collection, request.remote_ip) }
    # Convert the array of objects into an ActiveRecore::Relation object
    DigitalCollection.where(id: collections.map(&:id))
  end

  def private_collections
    collections = []
    DigitalCollection.find_each { |collection| collections << collection if is_private?(collection) }
    # Convert the array of objects into an ActiveRecore::Relation object
    DigitalCollection.where(id: collections.map(&:id))
  end
end
