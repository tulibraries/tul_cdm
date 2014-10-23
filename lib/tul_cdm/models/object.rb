module TulCdm::Models
  module Object
    extend ActiveSupport::Concern

    included do
     has_metadata name: "objectMetadata", label: "Object metadata", type: TulCdm::Datastreams::ObjectDatastream                   
     has_metadata name: "contentdmMetadata", label: "ContentDM generated metadata", type: TulCdm::Datastreams::ContentdmDatastream                   
    end

    

  end
end

