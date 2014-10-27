class PamphletMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.author(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string) 
    t.date_of_publication(:index_as=>[:facetable, :sortable], :type=>:string) 
    t.internal_note index_as: :displayable
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
  end
    
end