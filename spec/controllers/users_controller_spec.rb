require 'spec_helper'
require 'rails_helper'

describe UsersController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
  end

  describe 'GET show' do
    it "gets the right user" do
      get :show, {id: @user.id}
      expect(assigns(:user)).to eq(User.find_by(id: @user.id))
    end

    context 'when signed in' do
      it 'renders /show' do
        new_session
        get :show, {id: @user.id}
        expect(response).to render_template('users/show')
      end
    end

    context 'when not signed in' do
      it 'redirects home' do
        get :show, {id: @user.id}
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'GET new' do
    it 'creates an empty user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders /new' do
      get :new
      expect(response).to render_template('users/new')
    end
  end

  describe 'GET index' do
    context 'when signed in' do
      it 'renders /users' do
        new_session
        get :index
        expect(response).to render_template('users/index')
      end
    end

    context 'when not signed in' do
      it 'redirects home' do
        get :index
        expect(response).to redirect_to(root_url + 'signin')
      end
    end
  end

  describe 'POST create' do
    context 'with permitted params' do
      it 'creates a user' do
        expect {
          post :create, { user: valid_params}
        }.to change(User, :count).by(1)
      end

      it 'redirects to user' do
        post :create, {user: valid_params}
        user_id = assigns(:user).id.to_s
        expect(response).to redirect_to(root_url + 'users/' + user_id)
      end
    end

    context 'with invalid params' do
      it 'only has valid attributes' do
        expect {
          post :create, { user: invalid_params }
        }.to change(User, :count).by(1)

        expect(assigns(:user)).to have_attributes(valid_params)
        expect(assigns(:user)).not_to respond_to(:gar)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes a user' do
      allow(controller).to receive_messages(signed_in_user: true,
                                            admin_user: true)

      expect {
        delete :destroy, { id: @user.id }
      }.to change(User, :count)
    end

    it 'redirects to /index' do
      allow(controller).to receive_messages(signed_in_user: true,
                                            admin_user: true)
      delete :destroy, {id: @user.id}
      expect(response).to redirect_to(users_url)
    end
  end

  describe "GET edit" do
    it 'gets the right user' do
      new_session
      get :edit, { id: @user }
      expect(assigns(:user)).to eq(User.find_by(id: @user.id))
    end

    it 'renders /edit' do
      new_session
      get :edit, {id: @user}
      expect(response).to render_template('edit')
    end
  end

  describe "PATCH update" do
    it 'updates user attributes' do
      new_session
      patch :update, {id: @user.id, user: {name: "newname"}}
      expect(assigns(:user)).to eq(@user)
    end

    it 'redirects to user' do
      new_session
      patch :update, { id: @user.id, user: { name: "newname" }}
      expect(response).to redirect_to(@user)
    end
  end
end
