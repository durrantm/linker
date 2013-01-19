require 'spec_helper'

describe Group do

  let(:group) { FactoryGirl.create(:group) }

  subject { group }
  it { should be_valid }
  it { should have_attribute :group_name }
  it { should have_attribute :group_description }
  it { should validate_presence_of :group_name }
  it { should ensure_length_of(:group_name).is_at_most(20) }

end
