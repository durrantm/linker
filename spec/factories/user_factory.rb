FactoryGirl.define do

  factory :user do
    username "Michael Durrant"
  end

  factory :admin, parent: :group do
    username "Admin Durrant"
  end

  factory :user_admin, class: User do
    admin true
  end

end
