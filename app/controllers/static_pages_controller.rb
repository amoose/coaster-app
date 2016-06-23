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
        # @json = station_geolocations.to_gmaps4rails
        @station_gmaps ||= Gmaps4rails.build_markers(station_geolocations) do |geo, marker|
          marker.lat geo.latitude
          marker.lng geo.longitude
        end

        @user_gmaps ||= Gmaps4rails.build_markers(@current_user.geolocation) do |geo, marker|
          marker.lat geo.latitude
          marker.lng geo.longitude
        end
      end

      # @json ||= @station.geolocation.to_gmaps4rails

      @station_markers = @station_gmaps.to_json.html_safe
      @user_marker = @user_gmaps.to_json.html_safe
      @station ||= Station.first
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
