# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior

  #TODO: Figure out why BL Advanced search makes has_member_ssim not work, make it work
  include BlacklightAdvancedSearch::ParseBasicQ

  include TulCdm::SolrHelper::Behaviors

  # These before_filters apply the hydra access controls
  #before_filter :enforce_show_permissions, :only=>:show
  # This applies appropriate access controls to all solr queries
  #CatalogController.solr_search_params_logic += [:add_access_controls_to_solr_params]

  CatalogController.solr_search_params_logic += [:exclude_unwanted_models, :exclude_collections_by_ip]

  # def index
  #   super
  #   display_collection
  # end

  configure_blacklight do |config|
    config.default_solr_params = {
      :qf => 'creator_tesim
              document_content_tesim
              geographic_subject_tesim
              organization_building_tesim
              personal_names_tesim
              title_tesim
              date_tesim
              subject_tesim
              description_tesim
              format_tesim
              type_tesim
              publisher_tesim
              digital_collection_tesim
              digital_publisher_tesim
              contentdm_collection_id_tesim
              repository_tesim
              repository_collection_tesim
              identifier_tesim
              author_tesim
              is_part_of_ssim
              about_statement_tesim',
      :qt => 'search',
      :rows => 10
    }

    # solr field configuration for search results/index views
    config.index.title_field = 'title_tesim'
    config.index.display_type_field = 'has_model_ssim'
    config.show.display_type_field = 'active_fedora_model_ssi'

    config.index.thumbnail_field = 'path_to_thumbnail_ssm'


    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _tsimed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar

    config.add_facet_field solr_name('subject', :facetable), :label => 'Subject', :limit => 5, :collapse => false
    config.add_facet_field solr_name('date', :facetable), :label => 'Date', :limit => 5
    config.add_facet_field solr_name('format', :facetable), :label => 'Format', :limit => 5
    config.add_facet_field solr_name('type', :facetable), :label => 'Type', :limit => 5
    config.add_facet_field solr_name('publisher_sim', :facetable), :label => 'Publisher', :limit => 5
    config.add_facet_field solr_name('digital_collection', :facetable), :label => 'Digital Collection', :limit => 5, :collapse => false, :show => false
    config.add_facet_field solr_name('digital_publisher', :facetable), :label => 'Digital Publisher', :limit => 5
    config.add_facet_field solr_name('contentdm_collection_id', :facetable), :label => 'Digital Collection', :limit => 5, :single => false, :collapse => false, helper_method: :render_with_contentdm_collection_name
    config.add_facet_field solr_name('repository', :facetable), :label => 'Repository', :limit => 5
    config.add_facet_field solr_name('language', :facetable), :label => 'Language', :limit => 5
    config.add_facet_field solr_name('contributor', :facetable), :label => 'Contributor', :limit => 5
    config.add_facet_field solr_name('author', :facetable), :label => 'Author', :limit => 5
    config.add_facet_field solr_name('corporate_name', :facetable), :label => 'Corporate Name', :limit => 5
    config.add_facet_field solr_name('series', :facetable), :label => 'Series', :limit => 5
    config.add_facet_field solr_name('advisor', :facetable), :label => 'Series', :limit => 5
    config.add_facet_field solr_name('degree_granting_institution', :facetable), :label => 'Series', :limit => 5
    config.add_facet_field solr_name('year_prize_awarded', :facetable), :label => 'Prize Award Year', :limit => 5
    config.add_facet_field solr_name('is_part_of_ssim', :facetable), :label => 'Part Of'
    config.add_facet_field solr_name('personal_names', :facetable), :label => 'Personal Names', :limit => 5, :collapse => false, :show => true

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys
    #use this instead if you don't want to query facets marked :show=>false
    #config.default_solr_params[:'facet.field'] = config.facet_fields.select{ |k, v| v[:show] != false}.keys


    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name('title', :stored_searchable, type: :string), :label => 'Title'
    config.add_index_field solr_name('subject', :stored_searchable, type: :string), :label => 'Subject', :link_to_search => 'subject_sim'
    config.add_index_field solr_name('format', :stored_searchable, type: :string), :label => 'Format', :link_to_search => 'format_sim'

    # Collection-only metadata
    config.add_index_field solr_name('about_statement', :stored_searchable, type: :string), :label => 'About this Collection'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display

    # Records and shared metadata
    config.add_show_field solr_name('title', :stored_searchable, type: :string), :label => 'Title'
    config.add_show_field solr_name('alternate_title', :stored_searchable, type: :string), :label => 'Alternate Title'
    config.add_show_field solr_name('date', :stored_searchable, type: :string), :label => 'Date', :link_to_search => 'date_sim'
    config.add_show_field solr_name('date_range', :stored_searchable, type: :string), :label => 'Date Range'
    config.add_show_field solr_name('subject', :stored_searchable, type: :string), :label => 'Subject', :link_to_search => 'subject_sim'
    config.add_show_field solr_name('description', :stored_searchable, type: :string), :label => 'Description'
    config.add_show_field solr_name('format', :stored_searchable, type: :string), :label => 'Format', :link_to_search => 'format_sim'
    config.add_show_field solr_name('type', :stored_searchable, type: :string), :label => 'Type', :link_to_search => 'type_sim'
    config.add_show_field solr_name('publisher', :stored_searchable, type: :string), :label => 'Publisher', :link_to_search => 'publisher_sim'
    config.add_show_field solr_name('digital_collection', :stored_searchable, type: :string), :label => 'Digital Collection', :link_to_search => 'digital_collection_sim'
    config.add_show_field solr_name('digital_publisher', :stored_searchable, type: :string), :label => 'Digital Publisher', :link_to_search => 'digital_publisher_sim'
    config.add_show_field solr_name('contentdm_collection_id', :stored_searchable, type: :string), :label => 'Digital Collection ID', :link_to_search => 'contentdm_collection_id_sim', :show => false
    config.add_show_field solr_name('contact', :displayable, type: :string), :label => 'Contact'
    config.add_show_field solr_name('repository', :stored_searchable, type: :string), :label => 'Repository', :link_to_search => 'repository_sim'
    config.add_show_field solr_name('repository_collection', :stored_searchable, type: :string), :label => 'Repository Collection'
    config.add_show_field solr_name('language', :stored_searchable, type: :string), :label => 'Language', :link_to_search => 'language_sim'
    config.add_show_field solr_name('identifier', :displayable, type: :string), :label => 'Identifier'

    config.add_show_field solr_name('adapted_from', :stored_searchable, type: :string), :label => 'Adapted From'
    config.add_show_field solr_name('lithographer_printer', :stored_searchable, type: :string), :label => 'Lithographer / Printer'
    config.add_show_field solr_name('contributor', :stored_searchable, type: :string), :label => 'Contributor', :link_to_search => 'contributor_sim'
    config.add_show_field solr_name('cover_description', :stored_searchable, type: :string), :label => 'Cover Description'
    config.add_show_field solr_name('stereotypical_object_note', :stored_searchable, type: :string), :label => 'Object Note'
    config.add_show_field solr_name('donor_information', :stored_searchable, type: :string), :label => 'Donor Information'
    config.add_show_field solr_name('display_format', :stored_searchable, type: :string), :label => 'Display Format'

    config.add_show_field solr_name('series', :stored_searchable, type: :string), :label => 'Series'
    config.add_show_field solr_name('corporate_name', :stored_searchable, type: :string), :label => 'Corporate Name'
    config.add_show_field solr_name('volume', :stored_searchable, type: :string), :label => 'Volume'

    config.add_show_field solr_name('original_notes', :stored_searchable, type: :string), :label => 'Original Notes'
    config.add_show_field solr_name('photographer', :stored_searchable, type: :string), :label => 'Photographer'
    config.add_show_field solr_name('intersection', :stored_searchable, type: :string), :label => 'Intersection'

    config.add_show_field solr_name('author', :stored_searchable, type: :string), :label => 'Author'
    config.add_show_field solr_name('date_of_publication', :stored_searchable, type: :string), :label => 'Date of Publication'
    config.add_show_field solr_name('internal_note', :displayable, type: :string), :label => 'Internal Note'

    config.add_show_field solr_name('creator_person', :stored_searchable, type: :string), :label => 'Creator (Individual)'
    config.add_show_field solr_name('other_creator_person', :stored_searchable, type: :string), :label => 'Additional Creator (Individual)'
    config.add_show_field solr_name('creator_organization', :stored_searchable, type: :string), :label => 'Creator (Organization)'
    config.add_show_field solr_name('other_creator_organization', :stored_searchable, type: :string), :label => 'Additional Creator (Organization)'

    config.add_show_field solr_name('image_number', :stored_searchable, type: :string), :label => 'Image Number'

    config.add_show_field solr_name('clip_title', :stored_searchable, type: :string), :label => 'Clip Title'

    config.add_show_field solr_name('abstract', :stored_searchable, type: :string), :label => 'Abstract'
    config.add_show_field solr_name('accompanied_by', :stored_searchable, type: :string), :label => 'Accompanied By'
    config.add_show_field solr_name('accompanies', :stored_searchable, type: :string), :label => 'Accompanies'
    config.add_show_field solr_name('advisor', :stored_searchable, type: :string), :label => 'Advisor'
    config.add_show_field solr_name('committee_members', :stored_searchable, type: :string), :label => 'Committee Members'
    config.add_show_field solr_name('degree', :stored_searchable, type: :string), :label => 'Degree'
    config.add_show_field solr_name('degree_granting_institution', :stored_searchable, type: :string), :label => 'Degree Granting Institution'
    config.add_show_field solr_name('department', :stored_searchable, type: :string), :label => 'Department'
    config.add_show_field solr_name('file_size', :displayable, type: :string), :label => 'File Size'
    config.add_show_field solr_name('keywords', :stored_searchable, type: :string), :label => 'Keywords'
    config.add_show_field solr_name('source', :stored_searchable, type: :string), :label => 'Source'
    config.add_show_field solr_name('year_degree_awarded', :stored_searchable, type: :string), :label => 'Year Degree Awarded'
    config.add_show_field solr_name('year_prize_awarded', :stored_searchable, type: :string), :label => 'Year Prize Awarded'

    # Collection-only metadata
    config.add_show_field solr_name('about_statement', :stored_searchable, type: :string), :label => 'About this Collection'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', :label => 'All Fields'

    config.add_search_field('title') do |field|
      solr_name = solr_name("title_tesim", :stored_searchable, type: :string)
      field.qt = 'search'
      field.solr_local_parameters = {
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end

    config.add_search_field('subject') do |field|
      solr_name = solr_name("subject_tesim", :stored_searchable, type: :string)
      field.qt = 'search'
      field.solr_local_parameters = {
        :qf => '$subject_qf',
        :pf => '$subject_pf'
      }
    end

    config.add_search_field('digital_collection') do |field|
      solr_name = solr_name("digital_collection_tesim", :stored_searchable, type: :string)
      field.qt = 'search'
      field.solr_local_parameters = {
        :qf => '$digital_collection_qf',
        :pf => '$digital_collection_pf'
      }
    end

    config.advanced_search = {
      :form_solr_parameters => {
        "facet.field" => ["digital_collection_sim"],
        "facet.limit" => -1, # return all facet values
        "facet.sort" => "index" # sort by byte order of values
      }
    }

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, pub_date_dtsi desc, title_tesi asc', :label => 'relevance'
    config.add_sort_field 'title_tesi asc, pub_date_dtsi desc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  def exclude_unwanted_models(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    unwanted_models.each do |um|
    if um.kind_of?(String)
      model_uri = um
    else
      model_uri = um.to_class_uri
      end
    solr_parameters[:fq] << "-has_model_ssim:\"#{model_uri}\""
    end
    #[FIXME] using "-has_model_s" generatest error: "org.apache.solr.common.SolrException: undefined field has_model_s". Workaround below
    #solr_parameters[:fq] << "-has_model_s:\"info:fedora/afmodel:FileAsset\""
    solr_parameters[:fq] << "-has_model_ssim:\"info:fedora/afmodel:FileAsset\""
  end

  def unwanted_models
    #Add unwanted models below
    return []
  end

  def display_collection
    (resp, doc_list) = get_search_results(:q =>"{!lucene q.op=AND df=Food+conservation+--+United+States.}",
    :sort=>sort_field,
    :rows=>3)
    @document_list = doc_list[0..3]
  end

  def sort_field
    "#{self.class.solr_name('desc_metadata__title', :stored_sortable, type: :date)} desc"
  end

  def exclude_collections_by_ip(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    unviewable_collections.each do |vc|
      solr_parameters[:fq] << "-contentdm_collection_id_sim:#{vc.collection_alias}"
    end
    solr_parameters[:fq]
  end

end
