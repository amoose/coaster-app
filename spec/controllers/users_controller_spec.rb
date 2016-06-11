require 'spec_helper'
require 'rails_helper'

describe UsersController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
  end

  describe 'GET show' do
    it "shows the right user" do
      get :show, {id: @user.id}
      expect(assigns(:user)).to eq(User.find_by(id: @user.id))
    end
  end

  describe 'GET new' do
    it 'creates an empty user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET index' do
    # it 'shows all users' do
    #   get :index
    #   expect(assigns(:users)).to include(@user)
    # end
  end

  describe 'POST create' do
    context 'with permitted params' do
      it 'creates a user' do
        expect {
          post :create, { user: valid_params}
        }.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a user' do
        expect {
          post :create, invalid_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe 'DELETE destroy', :focus => true do
    it 'deletes a user' do
      allow(controller).to receive_messages(signed_in_user: true,
                                            admin_user: true)

      expect {
        delete :destroy, { id: @user.id }
      }.to change(User, :count)
    end
  end

  describe "GET edit" do
    it 'gets the right user' do
      sign_in_user
      get :edit, { id: @user }
      expect(assigns(:user)).to eq(User.find_by(id: @user.id))
    end
  end

  describe "PATCH update" do
    it 'updates user attributes' do
      sign_in_user
      patch :update, {id: @user.id, user: {name: "newname"}}
      expect(assigns(:user)).to eq(@user)
    end
  end
end
