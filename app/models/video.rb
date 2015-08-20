class Video < TulCdm::Models::Audiovisual

  has_metadata "descMetadata", type: VideoMetadata
  has_metadata "geographicMetadata", :type => TulCdm::Datastreams::GeographicDatastream
  has_metadata "physicalMetadata", :type => TulCdm::Datastreams::PhysicalDatastream
  has_metadata "digitalMetadata", :type => TulCdm::Datastreams::DigitalDatastream
  has_metadata "creationMetadata", :type => TulCdm::Datastreams::CreationDatastream
  has_metadata "volumeMetadata", :type => TulCdm::Datastreams::VolumeDatastream

  has_attributes :title,:format,:type, :publisher,:digital_collection,:digital_publisher,
    :digital_specifications,:contact,:repository,:repository_collection, :language,
    :identifier, datastream: 'objectMetadata', multiple: true

  has_attributes :downloadable, :downloadable_ocr, datastream: 'objectMetadata', multiple: false

  has_attributes :avsource, :clip_summary, :date_broadcast, :ensemble_identifier,
    :timecode_begin, :timecode_end, :transcript_filename, :original_source_summary,
    :original_source_title, datastream: 'avMetadata', multiple: true

  has_attributes :item_url, :oclc_number, :date_created, :date_modified, :contentdm_number,
    :contentdm_file_name, :contentdm_file_path, :contentdm_collection_id, datastream: 'contentdmMetadata', multiple: false

  has_attributes :clip_title, :contributor, datastream: 'descMetadata', multiple: true

  has_attributes :geographic_subject, :organization_building, datastream: 'geographicMetadata', multiple: true

  has_attributes :folder, :location, :physical_description, datastream: 'physicalMetadata', multiple: true

  has_attributes :notes, :personal_names, datastream: 'notationsMetadata', multiple: true

  has_attributes :file_name, :document_content, datastream: 'digitalMetadata', multiple: true

  has_attributes :created, :creator, datastream: 'creationMetadata', multiple: true


end
