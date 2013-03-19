class StationsController < ApplicationController
	def index
		@stations = Station.all
		@json = nil
		geolocations = []
		@stations.each do |station|
			geolocations << station.geolocation
		end

		@json = geolocations.to_gmaps4rails
	end

	def show
		@station = Station.find params[:id]
		@date = params[:date].nil? ? Date.today : Date.parse(params[:date])
		@trains = []
		@station.trains.each { |train| @trains << train if train.departs?(@date) }
	end
end
