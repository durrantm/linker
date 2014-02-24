FactoryGirl.define do

  factory :group do
    group_name "jQuery Examples"
    group_description "Various jQuery examples of common situations amnd solutions"
  end

  factory :invalid_group, parent: :group do
    group_name nil
  end

end
