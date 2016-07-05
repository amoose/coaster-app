class StaticPagesController < ApplicationController
  def home
    @stations = []
    if signed_in?

      geolocs = Geolocation.near(current_user.geolocation.address.nil? ? current_user.geolocation.fetch_address : current_user.geolocation.address).where(geocodeable_type: 'Station')
      geolocs.each do |loc|
        @stations << Station.find(loc.geocodeable_id)
      end

      @station = @stations.first
      @trains = []
      station_geolocations = []

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
          marker.infowindow Station.find(geo.geocodeable_id).name
          marker.picture(url: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
                         width: 50,
                         height: 50)
        end

        @user_gmaps ||= Gmaps4rails.build_markers(@current_user.geolocation) do |geo, marker|
          marker.lat geo.latitude
          marker.lng geo.longitude
          marker.infowindow User.find(geo.geocodeable_id).name
          marker.picture(url: user_marker_image(@current_user),
                         width: 50,
                         height: 50)
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
    # emptry
  end

  def contact
    # emptry1!!!
  end

  private

  def user_marker_image(user)
    if gravatar?(user)
      gravatar_url(user)
    else
      'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
    end
  end

  def gravatar?(user, options = {})
    hash = Digest::MD5.hexdigest(user.email.to_s.downcase)
    options = { rating: 'x', timeout: 2 }.merge(options)
    http = Net::HTTP.new('www.gravatar.com', 80)
    http.read_timeout = options[:timeout]
    response = http.request_head("/avatar/#{hash}?rating=#{options[:rating]}&default=http://gravatar.com/avatar")
    response.code != '302'
    # rescue StandardError, Timeout::Error
    #   true  # Don't show "no gravatar" if the service is down or slow
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = 50
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
