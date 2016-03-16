# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :manuscript do
    # objectMetadata attributes
    title ["Manuscript Title #{n}"]
    contentdm_collection_id "p16002coll14"
    type ["minutes", "correspondence", "reports", "notes"]
    format ["image/jp2"]
  end

  factory :manuscript_list , class: Manuscript do
    # objectMetadata attributes
    sequence(:title) {|n| ["Manuscript Title #{n}"] }
    contentdm_collection_id "p16002coll14"
    type ["minutes", "correspondence", "reports", "notes"]
    format ["image/jp2"]
  end
end
