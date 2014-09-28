require "spec_helper"

RSpec.describe FeatureSwitchesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/feature_switches").to route_to("feature_switches#index")
    end

    it "routes to #new" do
      expect(:get => "/feature_switches/new").to route_to("feature_switches#new")
    end

    it "routes to #show" do
      expect(:get => "/feature_switches/1").to route_to("feature_switches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/feature_switches/1/edit").to route_to("feature_switches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/feature_switches").to route_to("feature_switches#create")
    end

    it "routes to #update" do
      expect(:put => "/feature_switches/1").to route_to("feature_switches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/feature_switches/1").to route_to("feature_switches#destroy", :id => "1")
    end

  end
end
