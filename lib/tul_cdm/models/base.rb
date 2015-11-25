module TulCdm::Models
  class Base < ActiveFedora::Base
    include Hydra::AccessControls::Permissions

    include Condm
    belongs_to :collection, :property=> :is_member_of, :class_name => "ActiveFedora::Base"
  end
end
