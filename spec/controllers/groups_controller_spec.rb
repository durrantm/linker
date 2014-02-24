require 'spec_helper'

describe GroupsController do
  
  describe "admin access" do
    before :each do
      @group = FactoryGirl.create(:group, group_name: 'Tools', group_description: 'Tools and Utilities')
      user = FactoryGirl.create(:user, username: 'mdd', password: 'aaa', password_confirmation: 'aaa')
      session[:user_id] = user.id
    end
    
    describe 'GET #index' do    
      it "populates an array of groups" do
        get :index
        assigns(:groups).should eq([@group])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do    
      it "assigns the requested group to @group" do
        get :show, id: @group
        assigns(:group).should == @group
      end

      it "renders the :show template" do
        get :show, id: @group
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Group to @group" do
        get :new
        assigns(:group).should be_a_new(Group)
      end
      
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    
    describe 'GET #edit' do
      it "assigns the requested group to @group" do
        get :edit, id: @group
        assigns(:group).should == @group
      end
      
      it "renders the :edit template" do
        get :edit, id: @group
        response.should render_template :edit
      end
    end
  
    describe "POST #create" do
      
      context "with valid attributes" do
        it "creates a new group" do
          expect{
            post :create, group: FactoryGirl.attributes_for(:group)
          }.to change(Group,:count).by(1)
        end

        it "redirects to the new group" do
          a = post :create, group: FactoryGirl.attributes_for(:group)
          response.should redirect_to Group.unscoped.last
        end
      end

      context "with invalid attributes" do
        it "does not save the new group" do
          expect{
            post :create, group: FactoryGirl.attributes_for(:invalid_group)
          }.to_not change(Group,:count)
        end

        it "re-renders the new method" do
          post :create, group: FactoryGirl.attributes_for(:invalid_group)
          response.should render_template :new
        end
      end 
    end
  
    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @group" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:group)
          assigns(:group).should eq(@group)      
        end

        it "changes @group's attributes" do
          put :update, id: @group, 
            group: FactoryGirl.attributes_for(:group, 
              group_name: "test2", group_description: "test2")
          @group.reload
          @group.group_name.should eq("test2")
          @group.group_description.should eq("test2")
        end

        it "redirects to the updated group" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:group)
          response.should redirect_to @group
        end
      end

      context "invalid attributes" do
        it "locates the requested @group" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:invalid_group)
          assigns(:group).should eq(@group)      
        end

        it "does not change @group's attributes" do
          put :update, id: @group, 
            group: FactoryGirl.attributes_for(:group, 
              group_name: "XGroup", group_description: 'XGroup')
          @group.reload
          @group.group_name.should_not eq("Larry")
          @group.group_description.should_not eq("Smith")
        end

        it "re-renders the edit method" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:invalid_group)
          response.should render_template :edit
        end
      end
    end
  
    describe 'DELETE destroy' do
      it "deletes the group" do
        expect{
          delete :destroy, id: @group        
        }.to change(Group,:count).by(-1)
      end

      it "redirects to groups#index" do
        delete :destroy, id: @group
        response.should redirect_to groups_url
      end
    end
  end
  
  
  describe "view access" do
    before :each do
      @group = FactoryGirl.create(:group, group_name: 'Tools', group_description: 'Tools and Utilities')
    end
    
    describe 'GET #index' do    
      it "populates an array of groups" do
        get :index
        assigns(:groups).should eq([@group])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do    
      it "assigns the requested group to @group" do
        get :show, id: @group
        assigns(:group).should == @group
      end

      it "renders the :show template" do
        get :show, id: @group
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Group to @group" do
        get :new
        assigns(:group).should be_nil 
      end
      
      it "renders the :new template" do
        get :new
        response.should redirect_to ladmin_login_url
      end
    end
    
    describe 'GET #edit' do
      it "assigns the requested group to @group" do
        get :edit, id: @group
        assigns(:group).should be_nil
      end
      
      it "renders the :edit template" do
        get :edit, id: @group
        response.should redirect_to ladmin_login_url
      end
    end
  
    describe "POST #create" do
      
      context "with valid attributes" do
        it "creates a new group" do
          expect{
            post :create, group: FactoryGirl.attributes_for(:group)
          }.to_not change(Group,:count)
        end

        it "redirects to the new group" do
          post :create, group: FactoryGirl.attributes_for(:group)
          response.should redirect_to ladmin_login_url
        end
      end

      context "with invalid attributes" do
        it "does not save the new group" do
          expect{
            post :create, group: FactoryGirl.attributes_for(:invalid_group)
          }.to_not change(Group,:count)
        end

        it "re-renders the new method" do
          post :create, group: FactoryGirl.attributes_for(:invalid_group)
          response.should redirect_to ladmin_login_url
        end
      end 
    end
  
    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @group" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:group)
          assigns(:group).should be_nil
        end

        it "changes @group's attributes" do          
          put :update, id: @group, 
            group: FactoryGirl.attributes_for(:group, 
              group_name: "XTools", group_description: "XTools and Utilities")
          @group.reload
          @group.group_name.should_not eq("XTools")
          @group.group_description.should_not eq("XTools and Utilities")
        end

        it "redirects to the updated group" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:group)
          response.should redirect_to ladmin_login_url
        end
      end

      context "invalid attributes" do
        it "locates the requested @group" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:invalid_group)
          assigns(:group).should be_nil
        end

        it "does not change @group's attributes" do
          put :update, id: @group, 
            group: FactoryGirl.attributes_for(:group, 
              group_name: "XTools", group_description: nil)
          @group.reload
          @group.group_name.should_not eq("XTools")
          @group.group_description.should eq("Tools and Utilities")
        end

        it "re-renders the edit method" do
          put :update, id: @group, group: FactoryGirl.attributes_for(:invalid_group)
          response.should redirect_to ladmin_login_url
        end
      end
    end
  
    describe 'DELETE destroy' do
      it "deletes the group" do
        expect{
          delete :destroy, id: @group        
        }.to_not change(Group,:count)
      end

      it "redirects to groups#index" do
        delete :destroy, id: @group
        response.should redirect_to ladmin_login_url
      end
    end
  end
  
end
