FactoryGirl.define do
  factory :user do
    email "fred@example.com"
    password "fredspassword"
    password_confirmation "fredspassword"
  end
  factory :archivist_user, class: User do
    email "archivist1@example.com"
    password "tulcdmArchivist"
    password_confirmation "tulcdmArchivist"
  end
  factory :admin_user, class: User do
    email "admin@example.com"
    password "tulcdmAdmin"
    password_confirmation "tulcdmAdmin"
  end
end
