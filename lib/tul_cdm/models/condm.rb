module TulCdm::Models::Condm
    extend ActiveSupport::Concern

    included do
     has_metadata name: "contentdmMetadata", label: "CDM metadata", type: TulCdm::Datastreams::ContentdmDatastream   
     has_metadata name: "objectMetadata", label: "Object metadata", type: TulCdm::Datastreams::ObjectDatastream
    end

    

 
end

