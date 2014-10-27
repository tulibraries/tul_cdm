class ScholarshipMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.abstract index_as: :stored_searchable
    t.accompanied_by index_as: :stored_searchable 
    t.accompanies index_as: :stored_searchable 
    t.advisor(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
    t.contributor(:index_as=>[:facetable, :stored_searchable], :type=>:string)  
    t.author(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
    t.committee_members index_as: :stored_searchable 
    t.degree index_as: :stored_searchable 
    t.degree_granting_institution(:index_as=>[:facetable, :stored_searchable], :type=>:string) 
    t.department index_as: :stored_searchable 
    t.embargo_statement index_as: :displayable 
    t.file_size index_as: :displayable
    t.keywords index_as: :stored_searchable 
    t.restriction_note index_as: :displayable 
    t.source index_as: :stored_searchable 
    t.alternate_title index_as: :stored_searchable 
    t.year_degree_awarded index_as: :stored_searchable 
    t.ocr_note index_as: :displayable 
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def prefix
      ""
  end

end
