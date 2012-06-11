require 'spec_helper'

describe LinksController do
  
  describe "admin access" do
    before :each do
      @group= FactoryGirl.create(:group) 
      @link = FactoryGirl.create(:link, group: @group)
      user = FactoryGirl.create(:user, username: 'mdd', password: 'aaa', password_confirmation: 'aaa')
      session[:user_id] = user.id
      current_user = user
    end
    
    describe 'GET #index' do    
      it "populates an array of links" do
        get :index
        assigns(:links).should eq([@link])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do    
      it "assigns the requested link to @link" do
        get :show, id: @link
        assigns(:link).should == @link
      end

      it "renders the :show template" do
        get :show, id: @link
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Link to @link" do
        get :new
        assigns(:link).should be_a_new(Link)
      end
      
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    
    describe 'GET #edit' do
      it "assigns the requested link to @link" do
        get :edit, id: @link
        assigns(:link).should == @link
      end
      
      it "renders the :edit template" do
        get :edit, id: @link
        response.should render_template :edit
      end
    end
  
    describe "Link POST #create" do
      
      context "with valid attributes" do

        def do_post 
          attributes = FactoryGirl.build(:link).attributes.merge( :group_id => @group.id )
          post :create, :link => attributes 
        end

        it "creates a new link" do
          expect{
            do_post
            }.to change(Link, :count).by(1)
        end

        it "redirects to the new link" do
            do_post
            response.should redirect_to( assigns[:link])
        end

#        it "redirects to the new link" do
#          post :create, link: FactoryGirl.create(:link, :group => @group)
#          response.should redirect_to( assigns[:link]) 
#          response.should redirect_to @link # Link.unscoped.last
#          response.should redirect_to Link.unscoped.last # render_template :show
#        end
      end

      context "with invalid attributes" do
        it "does not save the new link" do
          expect{
            post :create, link: FactoryGirl.attributes_for(:invalid_link)
          }.to_not change(Link,:count)
        end

        it "re-renders the new method" do
          post :create, link: FactoryGirl.attributes_for(:invalid_link)
          response.should render_template :new
        end
      end 
    end
  
    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:link)
          assigns(:link).should eq(@link)      
        end

        it "changes @link's attributes" do
          put :update, id: @link, 
            link: FactoryGirl.attributes_for(:link, 
              url_address: "test2", alt_text: "test2")
          @link.reload
          @link.url_address.should eq("test2")
          @link.alt_text.should eq("test2")
        end

        it "redirects to the updated link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:link)
          response.should redirect_to @link
        end
      end

      context "invalid attributes" do
        it "locates the requested @link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:invalid_link)
          assigns(:link).should eq(@link)      
        end

        it "does not change @link's attributes" do
          put :update, id: @link, 
            link: FactoryGirl.attributes_for(:link, 
              url_address: "XLink", alt_text: 'XGroup')
          @link.reload
          @link.url_address.should_not eq("Larry")
          @link.alt_text.should_not eq("Smith")
        end

        it "re-renders the edit method" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:invalid_link)
          response.should render_template :edit
        end
      end
    end
  
    describe 'DELETE destroy' do
      it "deletes the link" do
        expect{
          delete :destroy, id: @link        
        }.to change(Link,:count).by(-1)
      end

      it "redirects to links#index" do
        delete :destroy, id: @link
        response.should redirect_to links_url
      end
    end
  end
  
  
  describe "view access" do
    before :each do
      @group= FactoryGirl.create(:group) 
      @link = FactoryGirl.create(:link, group: @group)
    end
    
    describe 'GET #index' do    
      it "populates an array of links" do
        get :index
        assigns(:links).should eq([@link])
      end
    
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  
    describe 'GET #show' do    
      it "assigns the requested link to @link" do
        get :show, id: @link
        assigns(:link).should == @link
      end

      it "renders the :show template" do
        get :show, id: @link
        response.should render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Link to @link" do
        get :new
        assigns(:link).should be_nil 
      end
      
      it "renders the :new template" do
        get :new
        response.should redirect_to ladmin_login_url
      end
    end
    
    describe 'GET #edit' do
      it "assigns the requested link to @link" do
        get :edit, id: @link
        assigns(:link).should be_nil
      end
      
      it "renders the :edit template" do
        get :edit, id: @link
        response.should redirect_to ladmin_login_url
      end
    end
  
    describe "POST #create" do
      
      context "with valid attributes" do
        it "creates a new link" do
          expect{
            post :create, link: FactoryGirl.attributes_for(:link)
          }.to_not change(Link,:count)
        end

        it "redirects to the new link" do
          post :create, link: FactoryGirl.attributes_for(:link)
          response.should redirect_to ladmin_login_url
        end
      end

      context "with invalid attributes" do
        it "does not save the new link" do
          expect{
            post :create, link: FactoryGirl.attributes_for(:invalid_link)
          }.to_not change(Link,:count)
        end

        it "re-renders the new method" do
          post :create, link: FactoryGirl.attributes_for(:invalid_link)
          response.should redirect_to ladmin_login_url
        end
      end 
    end
  
    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:link)
          assigns(:link).should be_nil
        end

        it "changes @link's attributes" do          
          put :update, id: @link, 
            link: FactoryGirl.attributes_for(:link, 
              link_name: "XTools", link_description: "XTools and Utilities")
          @link.reload
          @link.url_address.should_not eq("XTools")
          @link.alt_text.should_not eq("XTools and Utilities")
        end

        it "redirects to the updated link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:link)
          response.should redirect_to ladmin_login_url
        end
      end

      context "invalid attributes" do
        it "locates the requested @link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:invalid_link)
          assigns(:link).should be_nil
        end

        it "does not change @link's attributes" do
          put :update, id: @link, 
            link: FactoryGirl.attributes_for(:link, 
              link_name: "XTools", link_description: nil)
          @link.reload
          @link.url_address.should_not eq("XTools")
          @link.alt_text.should_not eq nil
        end

        it "re-renders the edit method" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:invalid_link)
          response.should redirect_to ladmin_login_url
        end
      end
    end
  
    describe 'DELETE destroy' do
      it "deletes the link" do
        expect{
          delete :destroy, id: @link        
        }.to_not change(Link,:count)
      end

      it "redirects to links#index" do
        delete :destroy, id: @link
        response.should redirect_to ladmin_login_url
      end
    end
  end
  
end
