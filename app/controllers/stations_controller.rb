class StationsController < ApplicationController
	def index
		@stations = Station.all
		@json = nil
		geolocations = []
		@stations.each do |station|
			geolocations << station.geolocation
		end

		@station_markers = Gmaps4rails.build_markers(geolocations) do |geo, marker|
			marker.lat geo.latitude
			marker.lng geo.longitude
			marker.infowindow Station.find(geo.geocodeable_id).name
		end

		@json = @station_markers.to_json.html_safe
	end

	def show
		@station = Station.find params[:id]
		@date = params[:date].nil? ? Date.today : Date.parse(params[:date])
		@trains = []
		@station.trains.each { |train| @trains << train if train.departs?(@date) }
		@trains.sort! { |a,b| a.departure_time <=> b.departure_time }
	end
end
