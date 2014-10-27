class EphemeraMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.corporate_name(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string) 
    t.series(:index_as=>[:facetable, :sortable], :type=>:string) 
    t.stereotypical_object_note index_as: :stored_searchable
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
    end
    
end