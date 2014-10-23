class SheetMusicMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.alternate_title index_as: :stored_searchable
    t.adapted_from index_as: :stored_searchable 
    t.date_range index_as: :stored_searchable 
    t.lithographer_printer index_as: :stored_searchable 
    t.contributor(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
    t.cover_description index_as: :stored_searchable 
    t.stereotypical_object_note index_as: :stored_searchable 
    t.donor_information index_as: :stored_searchable
    t.display_format index_as: :stored_searchable
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
  end
  
end