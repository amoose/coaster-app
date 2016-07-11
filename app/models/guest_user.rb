class GuestUser
  attr_accessor :geolocation
  def initialize(pos)
    @pos = pos
    @latitude = @pos[0]
    @longitude = @pos[1]
    @geolocation = set_geolocation
  end

  def set_geolocation
    Geolocation.new(address: nil,
                    accuracy: 9,
                    latitude: @latitude,
                    longitude: @longitude,
                    geocodeable_type: 'Guest User')
  end
end
