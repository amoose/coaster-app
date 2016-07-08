require 'spec_helper'
require 'rails_helper'

describe SessionsController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'POST create' do
    context 'with valid email/password' do
      it 'signs in a user' do
        post :create, session_valid_params
        expect(assigns(:user)).to eq(@user)

        expect(assigns(:current_user)).to eq(@user)
      end

      it 'renders user page' do
        post :create, session_valid_params
        expect(response).to redirect_to("#{root_url}users/#{@user.id}")
      end
    end

    context 'with invalid email/password' do
      it 'does not sign in a user' do
        post :create, session_invalid_params

        expect(assigns(:current_user)).to eq(nil)
      end

      it 'renders #new page' do
        post :create, session_invalid_params
        expect(response).to render_template("sessions/new")
      end
    end
  end

  describe "DELETE destroy" do
    it 'signs user out' do
      post :create, session_valid_params
      expect(assigns(:current_user)).to eq(@user)

      delete :destroy
      expect(assigns(:current_user)).to eq(nil)
    end

    it 'redirects to home' do
      post :create, session_valid_params
      expect(assigns(:current_user)).to eq(@user)

      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
