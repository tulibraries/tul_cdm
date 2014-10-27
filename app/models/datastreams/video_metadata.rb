class VideoMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.clip_title index_as: :stored_searchable 
    t.contributor(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string) 
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
    end
    
end