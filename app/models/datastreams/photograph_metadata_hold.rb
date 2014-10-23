class PhotographMetadata < ActiveFedora::NtriplesRDFDatastream

   map_predicates do |map|
    t.original_notes 

    t.photographer 

    t.intersection 

  end
  

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end
end
