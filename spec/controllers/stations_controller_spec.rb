require 'spec_helper'
require 'rails_helper'

describe StationsController, type: :controller do
  before do
    @user = FactoryGirl.create :user
    @station = FactoryGirl.create :station
  end

  describe 'GET home' do
    context 'when logged in' do
      before do
        new_session
      end

      it 'gets nearest' do
        get :nearest
        expect(response).to be_ok
      end

      it 'finds nearby stations' do
        user_location(@user)

        get :nearest

        expect(assigns(:stations)[0]).to have_attributes(name: 'Santa Fe Depot (San Diego)',
                                                         address: '1050 Kettner Blvd.',
                                                         city: 'San Diego',
                                                         state: 'CA',
                                                         zip: '92101',
                                                         zone_id: 3)
      end

      it 'finds trains for nearby stations', focus: :true do
        user_location(@user)

        get :nearest

        expect(assigns(:trains)).to eq(@station.trains)
      end
    end

    context 'when not logged in', focus: :true do
      it 'creates a guest user' do
        get :nearest
        expect(assigns(:user)).to be_a(GuestUser)
      end
    end
  end

  describe 'GET /index' do
    it 'lists all stations' do
      get :index
      expect(assigns(:stations)).to include(@station)
    end

    it 'loads station geolocations as json', focus: true do
      get :index
      @station_pos = { lat: @station.geolocation.latitude,
                       lng: @station.geolocation.longitude,
                       infowindow: @station.name }

      expect(assigns(:json)).to include(@station_pos.to_json)
    end
  end

  describe 'GET /show' do
    it 'assigns requested station correctly' do
      get :show, id: @station.id
      expect(assigns(:station)).to eq(@station)
    end

    context 'if date given' do
      it 'assigns the given date' do
        get :show, id: @station.id, date: 'Fri, 10 Jun 2016'
        expect(assigns(:date)).to eq('Fri, 10 Jun 2016'.to_date)
      end
    end

    context 'if date not given' do
      it 'assigns the date to today' do
        get :show, id: @station.id
        expect(assigns(:date)).to eq(Date.today)
      end
    end

    it "loads the station's trains departing on date" do
      @train = FactoryGirl.create :train

      get :show, id: @station.id
      expect(assigns(:trains)).to include(@station.trains.first)
    end
  end
end
