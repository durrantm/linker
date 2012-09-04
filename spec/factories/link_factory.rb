FactoryGirl.define do

 # @group = Group.new(:group_name => 'g', :group_description => 'g')

  factory :link do
    group {FactoryGirl.create(:group)} #:group
    url_address "http://test.com"
    alt_text "examples of common situations amnd solutions"
  end

  factory :invalid_link, parent: :link do
    group {FactoryGirl.create(:group)} #:group
    url_address nil
  end

end
