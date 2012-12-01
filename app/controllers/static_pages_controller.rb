class StaticPagesController < ApplicationController
  def home
    @current_user = current_user
    stations = Station.all
    @stations = {}
    stations.each do |station|
      @stations[station.name.to_sym] = []
      trains = station.trains.active
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
