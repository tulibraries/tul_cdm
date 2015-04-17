SitemapGenerator::Sitemap.default_host = "http://localhost:3000"

SitemapGenerator::Sitemap.create do
  # Home page
  add '/'

  # Advance Search Page
  add '/advanced'

  # Digital Collection Pages
  add '/digital_collections'

  # Each Digital Collection
  DigitalCollection.find_each do |digital_collection|
    # Digital Collection Landing Page
    add "/digital_collections/#{digital_collection.id}"

    # Digital Collection items
    ActiveFedora::Base.find_in_batches(contentdm_collection_id_tesim: digital_collection.collection_alias) do |group|
      group.each { |item| add "/catalog/#{item["id"]}" }
    end
  end
end
