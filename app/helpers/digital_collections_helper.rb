module DigitalCollectionsHelper

  def path(digital_collection)
    "/?f[contentdm_collection_id_sim][]=" + digital_collection.collection_alias.to_s
  end

  def name(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.name
  end

  def thumbnail(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.thumbnail_url
  end

  def description(collection_id)
    DigitalCollection.where(collection_alias: collection_id).first.description
  end

end
