require "open-uri"

module TulCdmHelper


  def display_field(document, solr_fname, label_text='', html_class)
    display_dt_dd_element(label_text, solr_field_value(document, solr_fname), html_class)
  end

  def link_to_high_res(document, collection_id, cdm_number)

    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    case model
      when 'Photograph'
        hr_scale = "25.000"
        hr_width = hr_height = 1400
        access_scale="10"
        access_width="512"
        access_height="414"
      when 'Poster'
        hr_scale="200"
        hr_width = hr_height = "2000"
      else
        path_end = ""
	  end
    path = "#{config['cdm_archive']}/utils/ajaxhelper/?CISOROOT=/#{collection_id}&CISOPTR=#{cdm_number}&action=2&DMSCALE=#{hr_scale}&DMWIDTH=#{hr_width}&DMHEIGHT=#{hr_height}"
    w_sb = 1400;
    link_to image_tag("#{config['cdm_archive']}/utils/ajaxhelper/?CISOROOT=#{collection_id}&CISOPTR=#{cdm_number}&action=2&DMSCALE=#{access_scale}&DMWIDTH=#{access_width}&DMHEIGHT=#{access_height}"), path.html_safe, :rel => "shadowbox[#{collection_id}-#{cdm_number}];width=#{w_sb}"
  end
  
  def link_to_download(document, collection_id, cdm_number)

    output = ''
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    case model
    when 'Clipping'
      hr_scale = "30.000"
    when 'Poster'
      hr_scale = "100"
    else
      hr_scale = "10.000"
    end
    hr_width="2000"
    hr_height="2000"
    file_name = document[:contentdm_file_name_tesim].first
    if (/\.(cpd|pdf)$/ =~ file_name)
        file_name = document[:contentdm_file_name_tesim].first.gsub(/\.cpd$/, ".pdf")
        path = "#{config['cdm_archive']}/utils/getfile/collection/#{collection_id}/id/#{cdm_number}/filename/#{file_name}"
    else
        file_name = document[:contentdm_file_name_tesim].first.gsub(/\.jp2$/, ".jpg")
        path = "#{config['cdm_archive']}/utils/ajaxhelper/?CISOROOT=/#{collection_id}&CISOPTR=#{cdm_number}&action=2&DMSCALE=#{hr_scale}&DMWIDTH=#{hr_width}&DMHEIGHT=#{hr_height}"
    end
    download_link = link_to t('tul_cdm.viewer.download_text'), path.html_safe, download: file_name, id: "download-link" 
    content_tag(:div, download_link, id: "download-link")
  end
  
  def render_image_viewer(document, collection_id, cdm_number)

    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    case model
      when 'Photograph'
        hr_scale = "25.000"
        hr_width = hr_height = "1400"
        access_scale="10"
        access_width="512"
        access_height="414"
      when 'Poster'
        hr_scale="800"
        hr_width = hr_height = "2000"
      else
        path_end = ""
	  end
    path = "#{config['cdm_archive']}/utils/ajaxhelper/?CISOROOT=/#{collection_id}&CISOPTR=#{cdm_number}&action=2&DMSCALE=#{hr_scale}&DMWIDTH=#{hr_width}&DMHEIGHT=#{hr_height}"

    # New stuff

    api_path="https://server16002.contentdm.oclc.org/dmwebservices/index.php?q=dmGetImageInfo/#{collection_id}/#{cdm_number.to_s}/xml"
    xml = Nokogiri::XML(open(api_path))
    pageWidth = xml.xpath("imageinfo/width/text()").to_s 
    pageHeight = xml.xpath("imageinfo/height/text()").to_s 
    pageScale = "100"

    cdm_data = { pageids:    [cdm_number].to_json,
                 cdmColl:    collection_id,
                 cdmArchive: config["cdm_archive"],
                 cdmServer:  config["cdm_server"],
                 cdmTitle:   document["title_tesim"].to_sentence,
                 cdmUrl:     path,
                 leafCount:  1,
                 pageWidth:  pageWidth,
                 pageHeight: pageHeight,
                 pageScale:  pageScale }

    output = ''
    output << content_tag(:div, "", id: "page-list", data: cdm_data )
    bookreader_invocation = "br.renderPagereader();"
    output << content_tag(:div, simple_format(t('tul_cdm.bookreader.title')) + content_tag(:noscript, t('tul_cdm.bookreader.caveat')), id: "BookReader")
    output << content_tag(:script, bookreader_invocation, type: "text/javascript")

    output.html_safe
  end
  
  # Returns the ActiveFedora model from the Solr document
  def model_from_document(document)
    active_fedora_model = document["active_fedora_model_ssi"]
  end
  
  def render_facet_widget(facet, option1)
    facet_chosen = [facet]
    options = [option1]
    render_facet_partials(facet_chosen,options)
  end
  
  def render_facet(facet)
    facet_select = [facet]
    render_facet_partials(facet_select)
  end
  
  def render_facet_groupings(group)
    sortby=["title_sim","date_range_sim","pub_date_dtsi"]
    geo=["geographic_subject_sim", "organization_building_sim","intersection_sim"]
    general=["type_sim", "subject_sim", "language_sim", "digital_collection_sim", "contentdm_collection_id_sim"]
    case group
      when 'sortby'
        grouping = sortby
      when 'geo'
        grouping = geo
      when 'general'
        grouping = general  
      else
        grouping = nil
      end
    
    render_facet_partials(grouping)

  end
  
  def render_facets_sortby
    output = ''
    title_sort_a = "?facet.sort=index&search_field=all_fields&sort=title_si+asc"
    title_sort_z = "?facet.sort=index&search_field=all_fields&sort=title_si+desc"
    date_sort_a = "?facet.sort=index&search_field=all_fields&sort=date_si+asc"
    date_sort_z = "?facet.sort=index&search_field=all_fields&sort=date_si+desc"
    
    title_full = link_to("Title", title_sort_a)
    title_a = link_to("[A - Z]", title_sort_a)
    title_z = link_to("[Z - A]", title_sort_z)
    
    date_full = link_to("Date", date_sort_a)
    date_a = link_to("[A - Z]", date_sort_a)
    date_z = link_to("[Z - A]", date_sort_z)
    
    output << "<ul>"
    output << '<div class="facet_limit">'
    output << "<li>#{title_full} <span class=\"a-z\">#{title_a}&nbsp;&nbsp;&nbsp;#{title_z}</span></li></div>"
    output << '<div class="facet_limit">'
    output << "<li>#{date_full}<span class=\"a-z\">#{date_a}&nbsp;&nbsp;&nbsp;#{date_z}</span></li></div>"
    output << "</ul>"
    output.html_safe
  end
  
  def render_pdf_reader(collection, pointer, name)
    document_pdf = contentdm_file_url(collection, pointer, name)
    pdf_object = content_tag(:object,'', data: document_pdf, type: "application/pdf", width: "100%", height: "100%")
    content_tag(:div, pdf_object, id: 'document-pdf')
  end

  def compound_document_content(document)
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    output=''
    cpd = ''
    page_ids_array=[]
    cdm_coll=document["contentdm_collection_id_tesim"].to_sentence if document["contentdm_collection_id_tesim"]
    cdm_num=document["contentdm_number_tesim"].to_sentence if document["contentdm_number_tesim"]
    if(document["file_name_ssm"])
      cpd = document["file_name_ssm"].to_sentence
    else
      fext = File.extname(document["contentdm_file_name_tesim"].to_sentence) if document["contentdm_file_name_tesim"]
      if(fext == ".cpd")
        cpd = "index.cpd"
      end
    end

    if(document["file_name_ssm"])
      cpd = document["file_name_ssm"].to_sentence
    else
      fext = File.extname(document["contentdm_file_name_tesim"].to_sentence) if document["contentdm_file_name_tesim"]
      if(fext == ".cpd")
        cpd = "index.cpd"
      end
    end
    if(cpd == "index.cpd")
      content_server = config["cdm_server"]
      api_path="#{content_server}/dmwebservices/index.php?q=dmGetCompoundObjectInfo/#{cdm_coll}/#{cdm_num}/xml"
      xml = Nokogiri::XML(open(api_path))
      compound_type = xml.xpath("/cpd/type/text()").to_s
      pamphlets_xpath="/cpd/node/page"
      default_xpath, manuscripts_xpath="/cpd/page"

      case model
        when 'Pamphlet'
          xpath_var = pamphlets_xpath
        else
          xpath_var = default_xpath
      end

      # Get document content
      pageptrs = xml.xpath("#{xpath_var}/pageptr/text()")
      pageptrs.each do |pageptr|
        api_path="#{content_server}/dmwebservices/index.php?q=dmItemHasOCRText/#{cdm_coll}/#{pageptr.to_s}/xml"
        xml_ItemHasOCRText = Nokogiri::XML(open(api_path))
        itemHasOCRText = xml_ItemHasOCRText.xpath("//hasOCR").text.to_i;
        api_path="#{content_server}/dmwebservices/index.php?q=dmGetItemInfo/#{cdm_coll}/#{pageptr.to_s}/xml"
        xml_ItemInfo = Nokogiri::XML(open(api_path))
        document_content = xml_ItemInfo.xpath('//docume')
        document_content.each do |content|
          output << content.text + " "
        end
      end
    end
    output.rstrip
  end

  def render_compound_pageturner(document)
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    output=''
    cpd = ''
    page_ids_array=[]
    cdm_coll=document["contentdm_collection_id_tesim"].to_sentence if document["contentdm_collection_id_tesim"]
    cdm_num=document["contentdm_number_tesim"].to_sentence if document["contentdm_number_tesim"]
    if(document["file_name_ssm"])
      cpd = document["file_name_ssm"].to_sentence
    else
      fext = File.extname(document["contentdm_file_name_tesim"].to_sentence) if document["contentdm_file_name_tesim"]
      if(fext == ".cpd")
        cpd = "index.cpd"
      end
    end
    if(cpd == "index.cpd")
      content_server = config["cdm_server"]
      api_path="#{content_server}/dmwebservices/index.php?q=dmGetCompoundObjectInfo/#{cdm_coll}/#{cdm_num}/xml"
      xml = Nokogiri::XML(open(api_path))
      compound_type = xml.xpath("/cpd/type/text()").to_s
      pamphlets_xpath="/cpd/node/page"
      default_xpath, manuscripts_xpath="/cpd/page"
      case model
        when 'Pamphlet'
          xpath_var = pamphlets_xpath
        else
          xpath_var = default_xpath
      end
      if (compound_type == "Document-PDF")
        output << render_pdf_reader(cdm_coll, cdm_num, '')
      else
        page_ids = xml.xpath("#{xpath_var}/pageptr/text()")
        page_titles = xml.xpath("#{xpath_var}/pagetitle/text()")
        page_ids.length.times do |i|
          page_ids_array[i] = page_ids[i].to_s
        end

        # Get height and width of first image
        api_path="#{content_server}/dmwebservices/index.php?q=dmGetImageInfo/#{cdm_coll}/#{page_ids.first.to_s}/xml"
        xml = Nokogiri::XML(open(api_path))
        pageWidth = xml.xpath("imageinfo/width/text()").to_s 
        pageHeight = xml.xpath("imageinfo/height/text()").to_s 
        pageScale = "20"

        cdm_data = { cpdType:    compound_type,
                     pageids:    page_ids_array.to_json,
                     cdmColl:    cdm_coll,
                     cdmNum:     cdm_num,
                     cdmArchive: config["cdm_archive"],
                     cdmServer:  config["cdm_server"],
                     cdmTitle:   document["title_tesim"].to_sentence,
                     cdmUrl:     document["reference_url_ssm"].to_sentence,
                     leafCount:  page_ids.length,
                     pageWidth:  pageWidth,
                     pageHeight: pageHeight,
                     pageScale:  pageScale }

        output << content_tag(:div, "", id: "page-list", data: cdm_data )
        bookreader_invocation = "br.renderBookreader();"
        output << content_tag(:div, simple_format(t('tul_cdm.bookreader.title')) + content_tag(:noscript, t('tul_cdm.bookreader.caveat')), id: "BookReader")
        output << content_tag(:script, bookreader_invocation, type: "text/javascript")
      end
    end
    output.html_safe
  end
 
  def render_video_player(document)
    output = ''
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    ensemble_identifier = document[:ensemble_identifier_tesim].first
    width = "640"
    height = "416"
    frame_width = 660
    frame_height = 436 
    video_width = 640
    video_height = 360
    ensemble_plugin = "https://ensemble.temple.edu/ensemble/app/plugin/plugin.aspx"
    ensemble_style_sheet = "https://ensemble.temple.edu/ensemble/app/plugin/css/ensembleEmbeddedContent.css"

    player_options = {
      "styleSheetUrl"  => ensemble_style_sheet,
      "contentID"      => ensemble_identifier,
      "useIFrame"      => true,
      "embed"          => true,
      "displayTitle"   => false,
      "startTime"      => 0,
      "autoPlay"       => true,
      "hideControls"   => false,
      "showCaptions"   => false,
      "width"          => video_width,
      "height"         => video_height,
      "displaySharing" => false,
      "q"              => config['cdm_archive']
    }

    player_src = ensemble_plugin + '?' + player_options.to_query
    output << content_tag(:div,
                          content_tag(:script,
                            "",
                            type: "text/javascript",
                            src: player_src,
                            frameborder: "0",
                            style: ["width: #{frame_width}px;", "height: #{frame_height}px;"],
                            escape: true).html_safe,
                          class: "ensembleEmbeddedContent",
                          id: "ensembleEmbeddedContent_#{ensemble_identifier}",
                          style: ["width: #{width}px;", "height: #{height}px;"])

    output.html_safe
  end

  def render_audio_player(document)
    output = ''
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    model = model_from_document(document)
    ensemble_identifier = document[:ensemble_identifier_tesim].first
    ensemble_plugin = "https://ensemble.temple.edu/ensemble/app/plugin/plugin.aspx"
    ensemble_style_sheet = "https://ensemble.temple.edu/ensemble/app/plugin/css/ensembleEmbeddedContent.css"

    player_options = {
      "styleSheetUrl"  => ensemble_style_sheet,
      "contentID"      => ensemble_identifier,
      "useIFrame"      => true,
      "embed"          => true,
      "displayTitle"   => false,
      "startTime"      => 0,
      "autoPlay"       => false,
      "hideControls"   => false,
      "showCaptions"   => false,
      "audio"          => true,
      "q"              => config['cdm_archive'],
      "frameborder"    => 0
    }

    player_src = ensemble_plugin + '?' + player_options.to_query
    output << content_tag(:div,
                          content_tag(:script,
                            "",
                            type: "text/javascript",
                            src: player_src).html_safe,
                          class: "ensembleEmbeddedContent",
                          id: "ensembleEmbeddedContent_#{ensemble_identifier}")

    output.html_safe
  end

###
#Temporary solution -- when we are OUT OF ContentDM, revisit this for addition to a datastream
###
  def render_reference_url(document)
    output=''
    text="Reference URL"
    output << link_to(text, document["reference_url_ssm"].to_sentence)
    output.html_safe
  end
  
###  
#Solr methods for field collapse
###  
  def less_important? field
    should_collapse = false
    less_important=["geographic_subject_sim", "organization_building_sim","intersection_sim"]
    if less_important.include? field
      should_collapse = true
    end
    return should_collapse
  end
  
  def should_collapse_facet? facet_field
     less_important?(facet_field.field)
  end
     
  def facet_field_id facet_field
    "facet-#{facet_field.field.parameterize}"
  end
  
  ##
  # Look up the label for the facet field
  def facet_field_label field
    label = blacklight_config.facet_fields[field].label
    solr_field_label(
      label,
      :"blacklight.search.fields.facet.#{field}",
      :"blacklight.search.fields.#{field}"
    )
  end
  
  
  def solr_field_label label, *i18n_keys
    if label.is_a? Symbol
      return t(label)
    end
    first, *rest = i18n_keys
    rest << label
    t(first, default: rest)
  end
  
  def query_subject display_field
    flash[:notice] = "Display: #{display_field.items.length}"
  end

  def set_children_link(document)
    model = model_from_document(document)
    if model == "Collection"
      link_to "Show all in collection", "/?q=is_member_of_ssim:info:fedora/#{document.id}"
    end
  end

  def set_collection_link(document)
    model = model_from_document(document)
    if model != "Collection"
      link_to "More like this", "/?q=is_member_of_ssim:#{document['is_member_of_ssim'].to_sentence if document['is_member_of_ssim']}"
    end
  end

  def render_collection(collection_id)
    # b = get_related_objects(collection_id);
    # collection_set = Array.new
    # b.each do |b_obj|
    #   pid=b_obj.id
    #   object = locate_by_model(pid)
    #   if(object)
    #    collection_item = [object.title.first]
    #    (collection_set ||= []) << collection_item
    #  end
    # end
    collection_set = 'placeholder for thumbnails'
    return collection_set
  end

  def get_related_objects(collection_id)
    related_objects = ActiveFedora::Base.where(is_member_of_ssim: collection_id).to_a
    return related_objects
  end

  def contentdm_file_url(collection, pointer, name)
    config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))
    output = "#{config['cdm_archive']}/utils/getfile/collection/#{collection}/id/#{pointer}/filename/#{name}"
  end

  def locate_by_model(pid)
    pid_fragments = pid.split(":");
    content_model = pid_fragments.first;
    case content_model
      when 'poster' then object = Poster.find(pid)
      when 'pamphlet' then object = Pamphlet.find(pid)
      else nil
    end
  end

  def object_model(object_type)
    object_map = YAML.load_file(File.expand_path("#{Rails.root}/config/object_mappings.yml", __FILE__))
    object_map[object_type]
  end

  def render_object_partial (document)
    partial = "show_" + object_model(model_from_document(document).downcase.to_sym)
    render partial, document: document
  end

end
