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

  def landing_page(host, digital_collection)
    if digital_collection.is_custom_landing_page? && !digital_collection.custom_url.blank?
      return digital_collection.custom_url
    end
    return "#{host}/#{digital_collection.slug}"
  end

  def link_to_digital_collection(digital_collection)
    digital_collection_path = digital_collection.custom_url.blank? ? path(digital_collection) : digital_collection.custom_url
    link_to raw("#{t('tul_cdm.digital_collection.browse_collection')} <span class=\"glyphicon glyphicon-circle-arrow-right\"></span>"), digital_collection_path
  end

end
