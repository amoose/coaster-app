require 'spec_helper'
require 'rails_helper'

describe StationsController, :type => :controller do
  before do
    @test_station = FactoryGirl.create :station
  end

  describe 'GET /index' do
    it "lists all stations" do
      get :index
      expect(assigns(:stations)).to include(@test_station)
    end

    it 'loads station geolocations as json', focus: true do
      get :index
      @test_station_pos = { lat: @test_station.geolocation.latitude,
                            lng: @test_station.geolocation.longitude,
                            infowindow: @test_station.name }

      expect(assigns(:json)).to include(@test_station_pos.to_json)
    end
  end

  describe 'GET /show' do
    it 'assigns requested station correctly' do
      get :show, {id: @test_station.id}
      expect(assigns(:station)).to eq(@test_station)
    end

    context 'if date given' do
      it 'assigns the given date' do
        get :show, {id: @test_station.id, date: "Fri, 10 Jun 2016"}
        expect(assigns(:date)).to eq("Fri, 10 Jun 2016".to_date)
      end
    end

    context 'if date not given' do
      it 'assigns the date to today' do
        get :show, {id: @test_station.id}
        expect(assigns(:date)).to eq(Date.today)
      end
    end

    it "loads the station's trains departing on date" do
      @train = FactoryGirl.create :train

      get :show, {id: @test_station.id}
      expect(assigns(:trains)).to include(@test_station.trains.first)
    end
  end
end
