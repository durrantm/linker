require 'spec_helper'

describe LinksController, type: :controller do

  describe "admin access" do
    before :each do
      @group= FactoryGirl.create(:group)
      @link = FactoryGirl.create(:link, group: @group)
      user = FactoryGirl.create(:user, username: 'mdd', password: 'aaa', password_confirmation: 'aaa')
      session[:user_id] = user.id
    end

    describe 'GET #index' do
      it "populates an array of links" do
        get :index
        expect(assigns(:links)).to eq [@link]
      end

      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it "assigns the requested link to @link" do
        get :show, id: @link
        expect(assigns(:link)).to eq @link
      end

      it "renders the :show template" do
        get :show, id: @link
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it "assigns a new Link to @link" do
        get :new
        expect(assigns(:link)).to be_a_new(Link)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it "assigns the requested link to @link" do
        get :edit, id: @link
        expect(assigns(:link)).to eq @link
      end

      it "renders the :edit template" do
        get :edit, id: @link
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do

      context "with valid attributes" do

        def do_post #( format = 'html' )
          attributes = FactoryGirl.build(:link).attributes.merge( :group_id => @group.id )
          post :create, :link => attributes, :format => 'html'
        end

        it "creates a new link" do
          expect{
            do_post
          }.to change(Link,:count).by(1)
        end

        it "redirects to the new link" do
          do_post
          expect(response).to redirect_to( assigns[:link] )
        end

      end

      describe "with invalid attributes" do
        it "does not save the new link" do
          expect{
            post :create, link: FactoryGirl.attributes_for(:invalid_link)
          }.to_not change(Link,:count)
        end

        it "re-renders the new method" do
          post :create, link: FactoryGirl.attributes_for(:invalid_link)
          expect(response).to render_template :new
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
        expect(response).to redirect_to links_url
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
        expect(assigns(:links)).to eq [@link]
      end

      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it "assigns the requested link to @link" do
        get :show, id: @link
        expect(assigns(:link)).to eq @link
      end

      it "renders the :show template" do
        get :show, id: @link
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it "assigns a new Link to @link" do
        get :new
        expect(assigns(:link)).to be_nil
      end

      it "renders the :new template" do
        get :new
        expect(response).to redirect_to ladmin_login_url
      end
    end

    describe 'GET #edit' do
      it "assigns the requested link to @link" do
        get :edit, id: @link
        expect(assigns(:link)).to be_nil
      end

      it "renders the :edit template" do
        get :edit, id: @link
        expect(response).to redirect_to ladmin_login_url
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
          expect(response).to redirect_to ladmin_login_url
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
          expect(response).to redirect_to ladmin_login_url
        end
      end
    end

    describe 'PUT #update' do
      context "valid attributes" do
        it "located the requested @link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:link)
          expect(assigns(:link)).to be_nil
        end

        it "changes @link's attributes" do
          put :update, id: @link,
            link: FactoryGirl.attributes_for(:link,
              link_name: "XTools", link_description: "XTools and Utilities")
          @link.reload
          expect(@link.url_address).to_not eq "XTools"
          expect(@link.alt_text).to_not eq "XTools and Utilities"
        end

        it "redirects to the updated link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:link)
          expect(response).to redirect_to ladmin_login_url
        end
      end

      context "invalid attributes" do
        it "locates the requested @link" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:invalid_link)
          expect(assigns(:link)).to be_nil
        end

        it "does not change @link's attributes" do
          put :update, id: @link,
            link: FactoryGirl.attributes_for(:link,
              link_name: "XTools", link_description: nil)
          @link.reload
          expect(@link.url_address).to_not eq "XTools"
          expect(@link.alt_text).to_not eq nil
        end

        it "re-renders the edit method" do
          put :update, id: @link, link: FactoryGirl.attributes_for(:invalid_link)
          expect(response).to redirect_to ladmin_login_url
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
        expect(response).to redirect_to ladmin_login_url
      end
    end
  end

end
