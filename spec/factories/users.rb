FactoryGirl.define do
  factory :user do
    email "fred@example.com"
    password "fredspassword"
    password_confirmation "fredspassword"
  end
end
