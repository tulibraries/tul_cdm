namespace :tu_cdm do
  namespace :collection do

    desc "Export digital collections into db/digital_collection.csv"
    task :export_csv => :environment do
      count = DigitalCollection.count
      puts "Exporting #{count} collections"

      CSV.open("db/digital_collection.csv", "wb") do |csv|
        csv << DigitalCollection.column_names
        DigitalCollection.all.each do |dc|
          csv << dc.attributes.values
        end
      end
    end

    desc "Import db/digital_collection.csv into the digital collections"
    task :import_csv => :environment do
      puts "Importing collections"
      exception_keys = ["id", "created_at", "updated_at"]

      begin
        CSV.foreach("db/digital_collection.csv", headers: true) do |row|
          collection = DigitalCollection.find_by_id(row["id"]) || DigitalCollection.new
          collection.attributes = row.to_hash.except(*exception_keys)
          collection.save!
        end
      rescue Exception => e
        raise e
      end
    end

  end

end
