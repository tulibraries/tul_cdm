module TulCdm::Models
  module AudVis
    extend ActiveSupport::Concern

    included do
     has_metadata name: "avMetadata", label: "Audiovisual metadata", type: TulCdm::Datastreams::AvDatastream   
    end

    

  end
end

