module TulCdm::Datastreams

  class NotationsDatastream < ActiveFedora::OmDatastream

    set_terminology do |t|
      t.root(path: "fields")
      t.notes(index_as: [:displayable, :stored_searchable], :type=>:string)
      t.personal_names(:index_as=>[:facetable, :stored_searchable], :type=>:string)

    end

    def self.xml_template
      Nokogiri::XML.parse("<fields/>")
    end

    def prefix
      ""
    end

  end

end
