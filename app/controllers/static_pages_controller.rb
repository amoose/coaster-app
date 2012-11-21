class StaticPagesController < ApplicationController
  def home
    @trains = Station.first.trains
    @zones = Zone.all
    @users = User.all
    if signed_in?
      params[:station_id] ||= Station.first.id
      @station = Station.find(params[:station_id])
      @trains = @station.trains
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
