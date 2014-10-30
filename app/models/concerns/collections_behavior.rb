module CollectionsBehaviour
	extend ActiveSupport::Concern
	module ClassMethods
		def retrieve_set_members pid
			fields = "is_member_of_ssim:info\\:fedora\\/" + pid
			options = {:fl=>["id", "title_tesim", "is_member_of_ssim", "active_fedora_model_ssi"], :rows=>10000, :sort=>"system_create_dtsi asc" }
			ActiveFedora::SolrService.query(fields,options)
		end
	end
end
