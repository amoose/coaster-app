class StaticPagesController < ApplicationController
  def home
    stations = Station.all
    @stations = {}
    stations.each do |station|
      @stations[station.name.to_sym] = []
      trains = station.trains.where('departure_time > ?',time_now).order('departure_time DESC')
      @stations[station.name.to_sym] << trains.each { |train| train }
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
