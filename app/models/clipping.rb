class Clipping < TulCdm::Models::Base
  
  has_metadata "descMetadata", type: ClippingMetadata
  has_metadata "geographicMetadata", :type => TulCdm::Datastreams::GeographicDatastream
  has_metadata "physicalMetadata", :type => TulCdm::Datastreams::PhysicalDatastream
  has_metadata "notationsMetadata", :type => TulCdm::Datastreams::NotationsDatastream
  has_metadata "digitalMetadata", :type => TulCdm::Datastreams::DigitalDatastream
  has_metadata "creationMetadata", :type => TulCdm::Datastreams::CreationDatastream
  
  delegate :title, to: 'objectMetadata'
  delegate :format, to: 'objectMetadata'
  delegate :type, to: 'objectMetadata'
  delegate :publisher, to: 'objectMetadata'
  delegate :digital_collection, to: 'objectMetadata'
  delegate :digital_publisher, to: 'objectMetadata'
  delegate :digital_specifications, to: 'objectMetadata'
  delegate :contact, to: 'objectMetadata'
  delegate :repository, to: 'objectMetadata'
  delegate :repository_collection, to: 'objectMetadata'
  delegate :language, to: 'objectMetadata'
  delegate :identifier, to: 'objectMetadata'
  
  delegate :item_url, to: 'contentdmMetadata'
  delegate :oclc_number, to: 'contentdmMetadata'
  delegate :date_created, to: 'contentdmMetadata'
  delegate :date_modified, to: 'contentdmMetadata'
  delegate :contentdm_number, to: 'contentdmMetadata'
  delegate :contentdm_file_name, to: 'contentdmMetadata'
  delegate :contentdm_file_path, to: 'contentdmMetadata'
  
  delegate :author, to: 'descMetadata'
  delegate :image_number, to: 'descMetadata'
  
  delegate :geographic_subject, to: 'geographicMetadata'
  delegate :organization_building, to: 'geographicMetadata'
  
  delegate :folder, to: 'physicalMetadata'
  delegate :location, to: 'physicalMetadata'
  delegate :physical_description, to: 'physicalMetadata'

  delegate :notes, to: 'notationsMetadata'
  delegate :personal_names, to: 'notationsMetadata'

  delegate :file_name, to: 'digitalMetadata'
  delegate :document_content, to: 'digitalMetadata'

  delegate :created, to: 'creationMetadata'
  delegate :creator, to: 'creationMetadata'

end
