class StaticPagesController < ApplicationController
  def home
    @stations = Station.all
    @zones = Zone.all
    @users = User.all
    if signed_in?

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
