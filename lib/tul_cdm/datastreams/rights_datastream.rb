module TulCdm::Datastreams
  
  class RightsDatastream < ActiveFedora::OmDatastream

    set_terminology do |t|
      t.root(path: "fields")
      t.rights index_as: :displayable
    
    end

    def self.xml_template
      Nokogiri::XML.parse("<fields/>")
    end

    def prefix
      ""
    end
  
  end

end
