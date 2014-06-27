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

  its "url check status code should be 2xx" do
    link.url_address = 'http://www.ixgxgxgihghghggoogle.com'
    expect(link.valid_get?).to be_false
  end

  its "url check status code should be 2xx" do
    link.url_address = 'http://www.google.com'
    expect(link.valid_get?).to be_true
  end

end
