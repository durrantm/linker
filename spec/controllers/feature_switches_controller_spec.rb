require 'spec_helper'

RSpec.describe FeatureSwitchesController, :type => :controller do

  before :each do
    @group = FactoryGirl.create(:group, group_name: 'Tools', group_description: 'Tools and Utilities')
    user = FactoryGirl.create(:user, username: 'mdd', password: 'aaa', password_confirmation: 'aaa')
    session[:user_id] = user.id
  end

  # This should return the minimal set of attributes required to create a valid
  # FeatureSwitch. As you add validations to FeatureSwitch, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
    name: 'test',
    description: 'test',
    conditions: 'test',
    status: 'test'
    }
  }

  let(:invalid_attributes) {
    {invalidy: 'invalidy'}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FeatureSwitchesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all feature_switches as @feature_switches" do
      feature_switch = FeatureSwitch.create! valid_attributes
      get :index, {}, valid_session
      expect(feature_switch).to be_a(FeatureSwitch)
    end
  end

  describe "GET show" do
    it "assigns the requested feature_switch as @feature_switch" do
      feature_switch = FeatureSwitch.create! valid_attributes
      get :show, {:id => feature_switch.to_param}, valid_session
      expect(feature_switch).to be_a(FeatureSwitch)
    end
  end

  describe "GET edit" do
    it "assigns the requested feature_switch as @feature_switch" do
      feature_switch = FeatureSwitch.create! valid_attributes
      get :edit, {:id => feature_switch.to_param}, valid_session
      expect(assigns(:feature_switch)).to eq(feature_switch)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new FeatureSwitch" do
        expect {
          post :create, {:feature_switch => valid_attributes}, valid_session
        }.to change(FeatureSwitch, :count).by(1)
      end

      it "assigns a newly created feature_switch as @feature_switch" do
        post :create, {:feature_switch => valid_attributes}, valid_session
        expect(assigns(:feature_switch)).to be_a(FeatureSwitch)
        expect(assigns(:feature_switch)).to be_persisted
      end

      it "redirects to the created feature_switch" do
        post :create, {:feature_switch => valid_attributes}, valid_session
        expect(response).to redirect_to(FeatureSwitch.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved feature_switch as @feature_switch" do
        post :create, {:feature_switch => invalid_attributes}, valid_session
        expect(@feature_switch).to_not be_a_new(FeatureSwitch)
      end

    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
        name: 'test',
        description: 'test',
        conditions: 'test',
        status: 'test'
        }
      }

      it "updates the requested feature_switch" do
        feature_switch = FeatureSwitch.create! valid_attributes
        put :update, {:id => feature_switch.to_param, :feature_switch => new_attributes}, valid_session
        feature_switch.reload
        expect(FeatureSwitch.count).to be 1
      end

      it "assigns the requested feature_switch as @feature_switch" do
        feature_switch = FeatureSwitch.create! valid_attributes
        put :update, {:id => feature_switch.to_param, :feature_switch => valid_attributes}, valid_session
        expect(assigns(:feature_switch)).to eq(feature_switch)
      end

      it "redirects to the feature_switch" do
        feature_switch = FeatureSwitch.create! valid_attributes
        put :update, {:id => feature_switch.to_param, :feature_switch => valid_attributes}, valid_session
        expect(response).to redirect_to(feature_switch)
      end
    end

    describe "with invalid params" do
      it "assigns the feature_switch as @feature_switch" do
        feature_switch = FeatureSwitch.create! valid_attributes
        put :update, {:id => feature_switch.to_param, :feature_switch => invalid_attributes}, valid_session
        expect(assigns(:feature_switch)).to eq(feature_switch)
      end

    end
  end

  describe "DELETE destroy" do
    it "destroys the requested feature_switch" do
      feature_switch = FeatureSwitch.create! valid_attributes
      expect {
        delete :destroy, {:id => feature_switch.to_param}, valid_session
      }.to change(FeatureSwitch, :count).by(-1)
    end

    it "redirects to the feature_switches list" do
      feature_switch = FeatureSwitch.create! valid_attributes
      delete :destroy, {:id => feature_switch.to_param}, valid_session
      expect(response).to redirect_to(feature_switches_url)
    end
  end

end
