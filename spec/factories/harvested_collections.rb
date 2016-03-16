# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :harvested_collection do
    sequence(:digital_collection_id) { |i| "p00000coll#{i}" }
    sequence(:xml_objects) { |i|
      [
        { "p0000coll#{i}x1" => "<xml><title>Object 1</title><dmrecord>1</dmrecord></xml>" },
        { "p0000coll#{i}x2" => "<xml><title>Object 1</title><dmrecord>2</dmrecord></xml>" },
        { "p0000coll#{i}x3" => "<xml><title>Object 1</title><dmrecord>3</dmrecord></xml>" },
        { "p0000coll#{i}x4" => "<xml><title>Object 1</title><dmrecord>4</dmrecord></xml>" },
      ]
    }
  end
end
