class GuestUser
  attr_accessor :geolocation
  def initialize(pos)
    @pos = pos
    @latitude = @pos[0].to_f
    @longitude = @pos[1].to_f
    @geolocation = set_geolocation
    @geolocation.fetch_address
  end

  def set_geolocation
    Geolocation.new(address: nil,
                    accuracy: 9,
                    latitude: @latitude,
                    longitude: @longitude,
                    geocodeable_type: 'Guest User')
  end
end
