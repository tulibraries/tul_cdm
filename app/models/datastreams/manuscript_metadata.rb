class ManuscriptMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.creator_person(:index_as=>[:facetable, :sortable], :type=>:string) 
    t.other_creator_person(:index_as=>[:facetable, :sortable], :type=>:string) 
    t.creator_organization(:index_as=>[:facetable, :sortable], :type=>:string) 
    t.other_creator_organization(:index_as=>[:facetable, :sortable], :type=>:string) 
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
    end
    
end