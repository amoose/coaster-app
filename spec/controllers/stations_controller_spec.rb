require 'spec_helper'
require 'rails_helper'

describe StationsController, type: :controller do
  before do
    @user = FactoryGirl.create :user
    @station = FactoryGirl.create :station
  end

  describe 'GET home' do
    before do
      new_session
    end

    it 'gets home' do
      get :home
      expect(response).to be_ok
    end
  end

  describe 'GET nearest' do
    it 'gets a position', focus: :true do
      get :nearest, user_coordinates

      expect(assigns(:position)).to eq([32.715736, -117.161087])
    end

    it 'finds nearby stations', focus: :true do
      get :nearest, user_coordinates

      expect(assigns(:stations)[0]).to have_attributes(name: 'Santa Fe Depot (San Diego)',
                                                       address: '1050 Kettner Blvd.',
                                                       city: 'San Diego',
                                                       state: 'CA',
                                                       zip: '92101',
                                                       zone_id: 3)
    end

    it 'finds trains for nearby stations' do
      get :nearest, user_coordinates

      expect(assigns(:trains)).to eq(@station.trains)
    end

    context 'when not signed in' do
      context 'with geolocating permission' do
        it 'creates a guest user' do
          get :nearest, user_coordinates

          expect(assigns(:user)).to be_a(GuestUser)
        end

        it 'creates a guest user geolocation' do
          get :nearest, user_coordinates

          expect(assigns(:user).geolocation.latitude).to eq(32.715736)
          expect(assigns(:user).geolocation.longitude).to eq(-117.161087)
        end
      end
    end
  end

  describe 'GET /index' do
    it 'lists all stations' do
      get :index
      expect(assigns(:stations)).to include(@station)
    end

    it 'loads station geolocations as json' do
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
