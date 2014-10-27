class ClippingMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.author(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string) 
    t.image_number(:index_as=>[:facetable, :sortable], :type=>:string) 
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
    end
    
end