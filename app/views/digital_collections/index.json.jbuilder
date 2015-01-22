json.array!(@digital_collections) do |digital_collection|
  json.extract! digital_collection, :id, :collection_alias, :name, :thumbnail_url, :description
  json.url digital_collection_url(digital_collection, format: :json)
end
