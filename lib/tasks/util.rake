namespace :tu_cdm do

  namespace :util do
    desc "Clear the cache"
    task :clear_cache => :environment do
      Rails.cache.clear
    end
  end

end
