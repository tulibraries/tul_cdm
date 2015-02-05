# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :manuscript do
    # objectMetadata attributes
    title ["Manuscript Title"]
    type ["minutes", "correspondence", "reports", "notes"]
    format ["image/jp2"]
  end
end
