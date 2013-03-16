class StaticPagesController < ApplicationController
  def home
    @stations = []
    if signed_in?

      geolocs = Geolocation.where(:geocodeable_type => 'Station').near(current_user.geolocation.address)

      geolocs.each do |loc|
        @stations << Station.find(loc.geocodeable_id)
      end
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
