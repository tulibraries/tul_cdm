class Clipping < TulCdm::Models::Base

  has_metadata "descMetadata", type: ClippingMetadata
  has_metadata "geographicMetadata", :type => TulCdm::Datastreams::GeographicDatastream
  has_metadata "physicalMetadata", :type => TulCdm::Datastreams::PhysicalDatastream
  has_metadata "notationsMetadata", :type => TulCdm::Datastreams::NotationsDatastream
  has_metadata "digitalMetadata", :type => TulCdm::Datastreams::DigitalDatastream
  has_metadata "creationMetadata", :type => TulCdm::Datastreams::CreationDatastream
  has_metadata "rightsMetadata", :type => TulCdm::Datastreams::RightsDatastream

  has_attributes :title,:format,:type, :publisher,:digital_collection,:digital_publisher,
    :digital_specifications,:contact,:repository,:repository_collection, :language,
    :identifier, :description, :ada_note, datastream: 'objectMetadata', multiple: true

  has_attributes :downloadable, :downloadable_ocr, datastream: 'objectMetadata', multiple: false

  has_attributes :item_url, :oclc_number, :date_created, :date_modified, :contentdm_number,
    :contentdm_file_name, :contentdm_file_path, :contentdm_collection_id, datastream: 'contentdmMetadata', multiple: false

  has_attributes :author, :image_number, datastream: 'descMetadata', multiple: true

  has_attributes :geographic_subject, :organization_building, datastream: 'geographicMetadata', multiple: true

  has_attributes :folder, :location, :physical_description, datastream: 'physicalMetadata', multiple: true

  has_attributes :notes, :personal_names, datastream: 'notationsMetadata', multiple: true

  has_attributes :file_name, :document_content, datastream: 'digitalMetadata', multiple: true

  has_attributes :created, :creator, datastream: 'creationMetadata', multiple: true

  has_attributes :rights, datastream: 'rightsMetadata', multiple: true

end
