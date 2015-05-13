class PosterMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
	t.title 
	t.format
	t.object_type
	t.publisher
	t.digital_collection
	t.digital_publisher
	t.digital_specifications
	t.contact
	t.repository
	t.repository_collection
	t.language
	t.identifier
	t.downloadable
	t.downloadable_ocr
	t.item_url
	t.oclc_number
	t.date_created
	t.date_modified
	t.contentdm_number
	t.contentdm_file_name
	t.contentdm_file_path
	t.contentdm_collection_id
	t.alternate_title
	t.acknowledgment
	t.contributor
	t.corporate_name
	t.hidden_date
	t.series
	t.volume
	t.folder
	t.location
	t.physical_description
	t.notes
	t.personal_names
	t.file_name
	t.document_content
	t.created
	t.creator
  end
    
  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end
end

