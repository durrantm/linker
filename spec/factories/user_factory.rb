FactoryGirl.define do

  factory :user do
    username "Michael Durrant"
    password "mdd"
    password_confirmation "mdd"
  end

  factory :invalid_user, parent: :user do
    username ""
  end

  factory :admin, parent: :user do
    username "Admin Durrant"
    admin true
  end

#  factory :user_admin, class: User do
#    admin true
#  end

end
