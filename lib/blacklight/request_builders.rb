module Blacklight
  module RequestBuilders
    extend ActiveSupport::Concern

    def add_facet_fq_to_solr(solr_parameters, user_params)
      solr_parameters["facet.sort"] = "index" # <==== Add this here

      # convert a String value into an Array
      if solr_parameters[:fq].is_a? String
        solr_parameters[:fq] = [solr_parameters[:fq]]
      end

      # :fq, map from :f.
      if ( user_params[:f])
        f_request_params = user_params[:f]

        f_request_params.each_pair do |facet_field, value_list|
          Array(value_list).each do |value|
            next if value.blank? # skip empty strings
            solr_parameters.append_filter_query facet_value_to_fq_string(facet_field, value)
          end
        end
      end
    end
    
  end
end
