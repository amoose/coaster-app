require 'spec_helper'
require 'rails_helper'

describe DestinationsController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user)

    @destination = FactoryGirl.create(:destination)
    @destination.user_id = @user.id
  end

  describe 'GET index' do
    it 'gets all destinations' do
      allow(controller).to receive(:signed_in_user).and_return(true)

      get :index, format: :json
      expect(JSON.parse(response.body)[0]).to include_json(JSON.parse(destination_attributes.to_json))
    end
  end

  describe 'GET show' do

    it 'shows correct destination' do
      allow(controller).to receive(:signed_in_user).and_return(true)

      get :show, { id: @destination.id, format: :json}
      expect(JSON.parse(response.body)).to include_json(JSON.parse(destination_attributes.to_json))
    end
  end

  describe 'GET new' do
    it 'creates an empty destination' do
      allow(controller).to receive(:signed_in_user).and_return(true)

      get :new
      expect(assigns(:destination)).to be_a_new(Destination)
    end
  end

  describe 'GET edit' do
    it 'gets the correct destination' do
      allow(controller).to receive_messages(signed_in_user: true,
                                            current_user: true)


      get :edit, { id: @destination.id}
      expect(assigns(:destination)).to eq(@destination)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new destination' do
        allow(controller).to receive_messages(signed_in_user: true,
                                              current_user: true)
        expect {
          post :create, destination_valid_params
        }.to change(Destination, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'only has valid attributes' do
        allow(controller).to receive_messages(signed_in_user: true,
                                              current_user: true)

        expect {
          post :create, destination_invalid_params
        }.to change(Destination, :count).by(1)

        expect(assigns(:destination).attributes).not_to include(:name)

      end
    end
  end

  describe 'PUT update' do
    it 'gets the correct destination' do
      allow(controller).to receive_messages(signed_in_user: true,
                                            current_user: true)

        put :update, {id: @destination.id,
                         destination:
                         { name: "Updated Name" }}

          expect(Destination.find(@destination.id).name).to eq("Updated Name")

    end
  end

  describe 'DELETE destroy' do
    it 'deletes a destination', focus: :true  do
      allow(controller).to receive(:signed_in_user).and_return(true)

      expect {
        delete :destroy, {id: @destination.id}
      }.to change(Destination, :count).by(-1)


    end
  end
end
