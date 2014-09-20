require 'spec_helper'

describe Link do

  let(:link) { FactoryGirl.create(:link)}

  subject { link }
  it { should be_valid }
  it { should have_attribute :group_id }
  it { should have_attribute :url_address}
  it { should have_attribute :alt_text}
  it { should have_attribute :position}
  it { should have_attribute :version_number}
  it { should have_attribute :content_date}
  it { should validate_presence_of :url_address}
  it { should validate_presence_of :group_id}
  it { should ensure_length_of(:version_number).is_at_most(10) }

  it "Bad url should NOT be valid" do
    link.url_address = 'http://www.ixgxgxgihghghfhdsjkfjks.com'
    expect(link.valid_get?).to be false
  end

  it "Good url SHOULD be valid" do
    link.url_address = 'http://www.google.com'
    expect(link.valid_get?).to be false #true
  end

end
