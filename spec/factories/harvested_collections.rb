# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :harvested_collection do
    sequence(:digital_collection_id) { |i| "p16002coll#{i}" }

    factory :harvested_collection_with_xml_objects do
      transient do
        item_count 4
      end
      after(:build) do |harvested_collection, evaluator|
        evaluator.xml_objects = {}
        objects_array = build_list(:xml_object, evaluator.item_count, collection: evaluator.digital_collection_id)
        objects_array.each do |o|
          evaluator.xml_objects.merge!(o)
        end
      end
    end

  end

  factory :xml_object, class: Hash do

    transient do
      collection "p16002coll1"
      sequence(:pid) { |i| "#{collection}x#{i}" }
      sequence(:xml_string) { |i| "<xml><title>Object #{i}</title><dmrecord>#{i}</dmrecord></xml>" }
    end

    after(:build)  { |xml_object, evaluator|
      xml_object[evaluator.pid.to_s] = evaluator.xml_string
    }
  end

end
