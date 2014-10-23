class PhotographMetadata < ActiveFedora::OmDatastream
  
  set_terminology do |t|
    t.root(path: "fields")
    t.original_notes index_as: :stored_searchable 
    t.photographer(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
    t.intersection(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
  end

end
