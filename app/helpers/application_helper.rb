module ApplicationHelper

  def render_with_contentdm_collection_name (collection_alias)
    digital_collection = DigitalCollection.find_by(collection_alias: collection_alias)
    digital_collection.name
  end

  def show_document_title (document)
    if not document[:title_tesim].blank?
      title = document[:title_tesim].first
    elsif not document[:clip_title_tesim].blank?
      title = document[:clip_title_tesim].first
    else
      title = document.id
    end
  end

end
