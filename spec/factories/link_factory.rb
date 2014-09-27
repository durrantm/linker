FactoryGirl.define do

  factory :link do
    group {FactoryGirl.create(:group)} #:group
    url_address {"http://test.com"+SecureRandom.uuid}
    alt_text "examples of common situations amnd solutions"
  end

  factory :valid_url_link, parent: :link do
    group {FactoryGirl.create(:group)} #:group
    url_address {"http://www.google.com"}
    alt_text "valid url"
  end

  factory :invalid_url_link, parent: :link do
    group {FactoryGirl.create(:group)} #:group
    url_address {"http://invalid_url_zxygtui"}
    alt_text "invalid url"
  end

  factory :invalid_link, parent: :link do
    group {FactoryGirl.create(:group)} #:group
    url_address nil
  end

end
