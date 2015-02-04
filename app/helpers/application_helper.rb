module ApplicationHelper

  def render_with_contentdm_collection_name (collection_alias)
    digital_collection = DigitalCollection.find_by(collection_alias: collection_alias)
    digital_collection.name
  end

end
