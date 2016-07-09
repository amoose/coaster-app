require 'spec_helper'
require 'rails_helper'

# geo = Geolocation.near(@user.geolocation).where(:geocodeable_type => 'Station')

describe StaticPagesController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @station = FactoryGirl.create(:station)
  end

  describe 'GET home' do
    it 'gets home' do
      new_session

      get :home
      expect(response).to be_ok
    end

    it 'finds nearby stations' do
      new_session
      user_location(@user)

      get :home

      expect(assigns(:stations)[0]).to have_attributes(name: 'Santa Fe Depot (San Diego)',
                                                       address: '1050 Kettner Blvd.',
                                                       city: 'San Diego',
                                                       state: 'CA',
                                                       zip: '92101',
                                                       zone_id: 3)
    end

    it 'finds trains for nearby stations', focus: :true do
      new_session
      user_location(@user)

      get :home

      expect(assigns(:trains)).to eq(@station.trains)
    end
  end
end
