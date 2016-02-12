require "active-fedora"
require "open-uri"
require "fileutils"

namespace :tu_cdm do

  OpenURI::Buffer.send :remove_const, 'StringMax'
  OpenURI::Buffer.const_set 'StringMax', 0

  config = YAML.load_file(File.expand_path("#{Rails.root}/config/contentdm.yml", __FILE__))

  desc "List current ContentDM collections on the CDM server"
  task :list => :environment do
    collections = CDMUtils.list(config['cdm_server'])
    collections.sort.each do |collection_alias, collection_name|
      printf "%-14s %s\n", collection_alias, collection_name
    end
  end

  desc "Download ContentDM specified collection in XML from CDM server"
  task :download, [:collection_name] => :environment do |t, args|
    args.download(:collection_name => nil)
    if args[:collection_name]
      downloaded = CDMUtils.download_one_collection(config, args[:collection_name])
    else
      downloaded = 0
      puts "No collection specified".colorize(:red)
    end

    message = "#{downloaded} #{'file'.pluralize(downloaded)} downloaded"
    puts downloaded == 0 ?  "Warning: #{message}".colorize(:red) : message
  end


  desc "Download all TULCDM digital collections from CONTENTdm in XML from CDM server"
  task :download_all => :environment do |t, args|
    downloaded = CDMUtils.download_all_collections(config)

    message = "#{downloaded} #{'file'.pluralize(downloaded)} downloaded"
    puts downloaded == 0 ?  "Warning: #{message}".colorize(:red) : message
  end


  desc 'Convert ContentDM custom XML to FOXML'
  task :convert => :environment do
    u_files = Dir.glob("#{config['cdm_download_dir']}/*.xml").select { |fn| File.file?(fn) }
    puts "#{u_files.length} collections detected"

    #TODO: exclude p16002coll10 and p16002coll18
    u_files.length.times do |i|
      CDMUtils.convert_file(u_files[i], config['cdm_foxml_dir'])
    end

  end


  desc "Ingest all converted and up-to-date ContentDM objects into Fedora"
  task :ingest => :environment do
    contents = ENV['DIR'] ? Dir.glob(File.join(ENV['DIR'], "*.xml")) : Dir.glob("#{config['cdm_foxml_dir']}/*.xml")
    contents.each do |file|
      pid = CDMUtils.ingest_file(file)
    end
    puts "All files ingested -- phew!".green

  end

  namespace :solr do
    desc "Reindex everything in Solr"
    task :reindex_all => :environment do
      ActiveFedora::Base.reindex_everything
    end

    desc "Delete a single item from Solr index"
    task :delete_one => :environment do
      #delete an object by ID from the Solr index:
      solr.delete_by_id("dpla:dpla_2", params: {'softCommit' => true})
    end
  end




  namespace :index do
    desc 'Index all Photograph objects in Fedora repo.'
    task :photographs => :environment do
      CDMUtils.index(Photograph)
    end

    desc 'Index all Transcript objects in Fedora repo.'
    task :transcripts => :environment do
      CDMUtils.index(Transcript)
    end

    desc 'Index all Poster objects in Fedora repo.'
    task :posters => :environment do
      CDMUtils.index(Poster)
    end

    desc 'Index all Manuscript objects in Fedora repo.'
    task :manuscripts => :environment do
      CDMUtils.index(Manuscript)
    end

    desc 'Index all Sheet Music objects in Fedora repo.'
    task :sheetmusic => :environment do
      CDMUtils.index(Sheetmusic)
    end

    desc 'Index all Clipping objects in Fedora repo.'
    task :clippings => :environment do
      CDMUtils.index(Clipping)
    end

    desc 'Index all Ephemera objects in Fedora repo.'
    task :ephemera => :environment do
      CDMUtils.index(Ephemera)
    end

    desc 'Index all Periodical objects in Fedora repo.'
    task :periodicals => :environment do
      CDMUtils.index(Periodical)
    end

    desc 'Index all Pamphlet objects in Fedora repo.'
    task :pamphlets => :environment do
      CDMUtils.index(Pamphlet)
    end

    desc 'Index all Scholarship objects in Fedora repo.'
    task :scholarship => :environment do
      CDMUtils.index(Scholarship)
    end

    desc 'Index all Audio objects in Fedora repo.'
    task :audio => :environment do
      CDMUtils.index(Audio)
    end

    desc 'Index all Video objects in Fedora repo.'
    task :video => :environment do
      CDMUtils.index(Video)
    end

    desc 'Index all Transcript objects in Fedora repo.'
    task :transcripts => :environment do
      CDMUtils.index(Transcript)
    end

  end
end
