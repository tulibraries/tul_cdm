SitemapGenerator::Sitemap.default_host = "http://localhost:3000"

SitemapGenerator::Sitemap.create do
  digital_collection_query = "/?f[contentdm_collection_id_sim][]="
  add '//digital_collections'
  DigitalCollection.find_each do |digital_collection|
    add "/digital_collections/#{digital_collection.id}"
    add "#{digital_collection_query}#{digital_collection.collection_alias}"
  end

  ActiveFedora::Base.find_each do |item|
    add "/catalog/#{item.pid}"
  end
end
