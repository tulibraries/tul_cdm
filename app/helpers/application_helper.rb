module ApplicationHelper

  def render_with_contentdm_collection_name (collection_alias)
    digital_collection = DigitalCollection.find_by(collection_alias: collection_alias)
    digital_collection.name
  rescue
    collection_alias
  end

  def show_document_title (document)
    if not document["title_tesim"].blank?
      title = document["title_tesim"].first
    elsif not document["clip_title_tesim"].blank?
      title = document["clip_title_tesim"].first
    else
      title = document_show_link_field(document)
    end
  end

  def search_placeholder_text
    if (controller_name == "digital_collections" && action_name == "show")
      placeholder_text = t('blacklight.search.placeholder.digital_collection')
    else
      t('blacklight.search.form.q')
    end
  end

end
