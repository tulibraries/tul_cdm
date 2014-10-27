module TulCdm

  module Datastreams
  
  class AvDatastream < ActiveFedora::OmDatastream

    set_terminology do |t|
      t.root(path: "fields")
      t.avsource index_as: :stored_searchable
      t.clip_summary index_as: :stored_searchable
      t.date_broadcast index_as: :displayable
      t.ensemble_identifier index_as: :stored_searchable
      t.timecode_begin index_as: :displayable
      t.timecode_end index_as: :displayable
      t.transcript_filename index_as: :stored_searchable
      t.original_source_summary index_as: :stored_searchable
      t.original_source_title index_as: :stored_searchable
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
