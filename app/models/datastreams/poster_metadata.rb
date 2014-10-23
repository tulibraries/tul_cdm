class PosterMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.alternate_title index_as: :stored_searchable
    t.series index_as: :stored_searchable 
    t.hidden_date index_as: :stored_searchable 
    t.contributor(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
    t.corporate_name index_as: :stored_searchable 
    t.volume index_as: :stored_searchable 
    t.acknowledgment index_as: :stored_searchable 
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end
end