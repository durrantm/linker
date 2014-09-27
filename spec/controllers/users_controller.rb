require 'spec_helper'

describe UsersController, type: :controller do

  describe "admin access" do
    before :each do
      @user = FactoryGirl.create(:user, username: 'mdd', password: 'aaa', password_confirmation: 'aaa')
      session[:user_id] = @user.id
    end

    describe 'GET #index' do
      it "populates an array of users" do
        get :index
        expect(assigns(:users)).to eq ([@user])
      end

      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it "assigns the requested user to @user" do
        get :show, id: @user
        expect(assigns(:user)).to eq @user
      end

      it "renders the :show template" do
        get :show, id: @user
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it "assigns a new User to @user" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it "assigns the requested user to @user" do
        get :edit, id: @user
        expect(assigns(:user)).to eq @user
      end

      it "renders the :edit template" do
        get :edit, id: @user
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do

      context "with valid attributes" do
        it "creates a new user" do
          expect{
            post :create, user: FactoryGirl.attributes_for(:user)
          }.to change(User,:count).by(1)
        end

      end

      context "with invalid attributes" do
        it "does not save the new user" do
          expect{
            post :create, user: FactoryGirl.attributes_for(:invalid_user)
          }.to_not change(User,:count)
        end

        it "re-renders the new method" do
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PUT #update' do
      context "valid attributes" do

        it "changes @user's attributes" do
          put :update, id: @user,
            user: FactoryGirl.attributes_for(:user,
              username: "test2")
          @user.reload
          expect(@user.username).to eq ("test2")
        end

        it "redirects to the updated user" do
          put :update, id: @user, user: FactoryGirl.attributes_for(:user)
          expect(response).to redirect_to @user
        end
      end

      context "invalid attributes" do
        it "does not change invalid attributes for the requested @user" do
          expect{put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)}.to raise_error(ActiveRecord::RecordInvalid)
        end

      end
    end

    describe 'DELETE destroy' do
      it "redirects to user#index" do
        delete :destroy, id: @user
        expect(response).to redirect_to users_url
      end
    end
  end

end
