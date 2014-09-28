require 'spec_helper'

describe FeatureSwitch, :type => :model do
  it "should be possible tro create a FeatureSwitch" do
    fs = FeatureSwitch.new(status: 'on', name: 'scolling_table_link_index', description: 'A scrolling table for the index view of links', conditions: '')
    expect(fs).to be_a FeatureSwitch
  end
end
