class Poster < ActiveFedora::Base
  
  contains 'descMetadata', class_name: 'PosterMetadata'

  property :title, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :format, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :object_type, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :publisher, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :digital_collection, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :digital_publisher, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :digital_specifications, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :contact, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :repository, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :repository_collection, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :language, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :identifier, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :downloadable, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :downloadable_ocr, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :item_url, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :oclc_number, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :date_created, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :date_modified, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :contentdm_number, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :contentdm_file_name, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :contentdm_file_path, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :contentdm_collection_id, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :alternate_title, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :acknowledgment, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :contributor, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :corporate_name, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :hidden_date, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :series, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :volume, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :folder, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :location, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :physical_description, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :notes, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :personal_names, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :file_name, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :document_content, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :created, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  property :creator, delegate_to: 'descMetadata', multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
  
  # Uncomment the following lines to add an #attachment method that is a file
  #
  # contains "attachment"
  
  #
  # If you need to add additional attributes to the SOLR document, extend the default indexer:
  #
  # def indexer
  #   MyApp::IndexingService
  # end
  #
  # This can go into app/services/my_app/indexing_service.rb
  # module MyApp
  #   class IndexingService < ActiveFedora::IndexingService
  #     def generate_solr_document
  #       super.tap do |solr_doc|
  #         solr_doc["my_attribute_s"] = objecproperty :my_attribute
  #       end
  #     end
  #   end
  # end
end
