class StaticPagesController < ApplicationController
  def home
    @stations = []
    if signed_in?

      geolocs = Geolocation.near(current_user.geolocation.address.nil? ? current_user.geolocation.fetch_address : current_user.geolocation.address).where(:geocodeable_type => 'Station')
      geolocs.each do |loc|
        @stations << Station.find(loc.geocodeable_id)
      end

      @station = @stations.first
      @trains =   []
      station_geolocations =     []

      if @station
        @station.trains.each do |train|
          @trains << train if train.departs?
        end

        @stations.each do |station|
          station_geolocations << station.geolocation
        end

        # @json = Geolocation.where
        @json = station_geolocations.to_gmaps4rails
      end

      @station ||= Station.first
      @json ||= @station.geolocation.to_gmaps4rails
      @trains ||= @station.trains
    end
  end

  def help

  end

  def about
  	#emptry
  end

  def contact
  	# emptry1!!!
  end


end
