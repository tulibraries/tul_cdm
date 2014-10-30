class Collection < ActiveFedora::Base
  has_metadata 'descMetadata', type: CollectionMetadata

  has_many :children, :property=> :is_member_of, :class_name => "ActiveFedora::Base"

  has_attributes :title, datastream: 'descMetadata', multiple: false
  has_attributes :about_statement, datastream: 'descMetadata', multiple: false

end