class StaticPagesController < ApplicationController
  def home
    @stations = []
    if signed_in?

      geolocs = Geolocation.near(current_user.geolocation.address.nil? ? current_user.geolocation.fetch_address : current_user.geolocation.address).where(:geocodeable_type => 'Station')
      # geolocs.each do |loc|
      #   @stations << Station.find(loc.geocodeable_id)
      # end

      # @stations = Station.where(:id => geolocs.map(&:geocodeable_id))

      begin
        @station = Station.where(:id => geolocs.first.geocodeable_id).first
        @trains = Train.departing(@station)
        station_geolocations =     []


        @date = params[:date].nil? ? Date.today : Date.parse(params[:date])
      rescue => e
        flash.now e.message
      end

      @station ||= Station.first
      # @json ||= @station.geolocation
      @json = current_user.geolocation
      # @trains ||= @station.trains
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
