class CollectionMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.title(:index_as=>[:facetable, :sortable, :stored_searchable], :type=>:string)
    t.about_statement(index_as: :stored_searchable)
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
    # set a datastream prefix if you need to namespace terms that might occur in multiple data streams 
    ""
  end

end