module TulCdm

  module Datastreams
  
  class ContentdmDatastream < ActiveFedora::OmDatastream

    set_terminology do |t|
      t.root(path: "fields")
      t.item_url index_as: :stored_searchable
      t.oclc_number index_as: :stored_searchable
      t.date_created index_as: :stored_searchable
      t.date_modified index_as: :stored_searchable
      t.contentdm_number index_as: :stored_searchable
      t.contentdm_file_name index_as: :stored_searchable
      t.contentdm_file_path index_as: :stored_searchable
      t.contentdm_collection_id(:index_as => [:facetable, :sortable, :stored_searchable], :type=>:string)
      t.path_to_thumbnail index_as: :displayable
      t.reference_url index_as: :displayable
      t.compound index_as: :displayable
    end 

    def self.xml_template
      Nokogiri::XML.parse("<fields/>")
    end

    def prefix
      ""
    end
  
  end

end
end
