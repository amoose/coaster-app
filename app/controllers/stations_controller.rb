class StationsController < ApplicationController
	def index
		@stations = Station.all
		@json = nil
		geolocations = []
		@stations.each do |station|
			geolocations << station.geolocation
		end

		@json = Gmaps4rails.build_markers(geolocations) do |geo, marker|
			marker.lat geo.latitude
			marker.lng geo.longitude
		end
	end

	def show
		@station = Station.find params[:id]
		@date = params[:date].nil? ? Date.today : Date.parse(params[:date])
		@trains = []
		@station.trains.each { |train| @trains << train if train.departs?(@date) }
	end
end
