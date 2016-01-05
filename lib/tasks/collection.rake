namespace :tu_cdm do
  namespace :collection do

    desc "Export digital collections to a CSV file"
    task :export_csv => :environment do
      count = DigitalCollection.count
      puts "Exporting #{count} collections"

      CSV.open("digital_collection.csv", "wb") do |csv|
        csv << DigitalCollection.column_names
        DigitalCollection.all.each do |dc|
          csv << dc.attributes.values
        end
      end
    end

    desc "Import digital collections from a CSV file"
    task :import_csv => :environment do
      puts "Importing collections"
      exception_keys = ["id", "created_at", "updated_at"]

      begin
        CSV.foreach("digital_collection.csv", headers: true) do |row|
          collection = DigitalCollection.find_by_id(row["id"]) || new
          collection.attributes = row.to_hash.except(*exception_keys)
          collection.save!
        end
      rescue
        puts "Failed"
      end
    end

  end

end
