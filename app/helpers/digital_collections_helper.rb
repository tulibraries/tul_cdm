module DigitalCollectionsHelper

  def path(digital_collection)
    "/?f[digital_collection_sim][]=" + digital_collection.name
  end

  def name(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.name
  end

  def image(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.image_url
  end

  def thumbnail(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.thumbnail_url
  end

  def description(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.description
  end

end
