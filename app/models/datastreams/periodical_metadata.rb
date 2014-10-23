class PeriodicalMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.issue_title(:index_as=>[:sortable, :stored_searchable], :type=>:string) 
    t.ocr_note index_as: :displayable
    
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
    end
    
end