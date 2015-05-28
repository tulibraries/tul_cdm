module TulCdm::Datastreams

  class DigitalDatastream < ActiveFedora::OmDatastream

    set_terminology do |t|
      t.root(path: "fields")
      t.file_name index_as: :displayable
      t.document_content {
        t.page {
          t.contentdm_ptr(:index_as=>:stored_searchable, :type=>:string)
          t.text(:index_as=>:stored_searchable, :type=>:string)
        }
      }

    end

    def self.xml_template
      Nokogiri::XML.parse("<fields/>")
    end

    def prefix
      ""
    end

  end

end
