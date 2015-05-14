class Poster < ActiveFedora::Base
  
  #contains 'descMetadata', class_name: 'PosterMetadata'

  property :title, predicate: ::RDF::DC.title, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  
  property :object_type, predicate: ::RDF::DC.type, multiple: false do |index|
    index.as :stored_searchable, :facetable
  end
  
  property :publisher, predicate: ::RDF::DC.publisher, multiple: false do |index|
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
