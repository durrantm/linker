require 'spec_helper'

RSpec.describe "feature_switches/show", :type => :view do
  before(:each) do
    @feature_switch = assign(:feature_switch, FeatureSwitch.create!(
      :status => "MyText",
      :name => "MyText",
      :description => "MyText",
      :conditions => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
