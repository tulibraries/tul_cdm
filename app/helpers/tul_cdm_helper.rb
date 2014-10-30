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
    general=["digital_collection_sim","type_sim", "subject_sim", "language_sim"]
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
  
  def render_compound_pageturner(document)
    model = model_from_document(document)
    output=''
    cpd = ''
    page_ids_array=[]
    cdm_coll=document["contentdm_collection_id_tesim"].to_sentence if document["contentdm_collection_id_tesim"]
    cdm_num=document["contentdm_number_tesim"].to_sentence if document["contentdm_number_tesim"]
    if(document["file_name_ssm"])
      cpd = document["file_name_ssm"].to_sentence
    else
      fext = File.extname(document["contentdm_file_name_tesim"].to_sentence)
      if(fext == ".cpd")
        cpd = "index.cpd"
      end
    end
    if(cpd == "index.cpd")
      api_path="https://server16002.contentdm.oclc.org/dmwebservices/index.php?q=dmGetCompoundObjectInfo/#{cdm_coll}/#{cdm_num}/xml"
      xml = Nokogiri::XML(open(api_path))
      pamphlets_xpath="/cpd/node/page"
      default_xpath, manuscripts_xpath="/cpd/page"
      case model
        when 'Pamphlet'
          xpath_var = pamphlets_xpath
        else
          xpath_var = default_xpath
      end
      page_ids = xml.xpath("#{xpath_var}/pageptr/text()")
      page_titles = xml.xpath("#{xpath_var}/pagetitle/text()")
      page_ids.length.times do |i|
        small_path="http://digital.library.temple.edu/utils/ajaxhelper/?CISOROOT=#{cdm_coll}&CISOPTR=#{page_ids[i].to_s.to_i}&action=2&DMSCALE=5&DMWIDTH=2000&DMHEIGHT=4000"
        inv_path="http://digital.library.temple.edu/utils/ajaxhelper/?CISOROOT=#{cdm_coll}&CISOPTR=#{page_ids[i].to_s.to_i}&action=2&DMSCALE=0.1&DMWIDTH=2000&DMHEIGHT=4000"
        full_path="http://digital.library.temple.edu/utils/ajaxhelper/?CISOROOT=#{cdm_coll}&CISOPTR=#{page_ids[i].to_s.to_i}&action=2&DMSCALE=20&DMWIDTH=2000&DMHEIGHT=4000"
        if i == 0
          output << (link_to(image_tag(small_path, :alt => page_titles[i].to_s, :title => page_titles[i].to_s, :class => 'thumb-single'), full_path, :title => page_titles[i].to_s, :rel => "shadowbox[#{cdm_coll}-#{cdm_num}]"))
        else
          output << (link_to(image_tag(inv_path, :alt => page_titles[i].to_s, :title => page_titles[i].to_s, :class => 'hidden', :width => '1', :height => '1'), full_path, :title => page_titles[i].to_s, :rel => "shadowbox[#{cdm_coll}-#{cdm_num}];height=600;width=400"))
        end
      end
    end
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
  
end
