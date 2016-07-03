require 'csv'
require 'open-uri'
require 'colorize'

def friendly_put(msg, status=:success)
  puts '✓ '.green + msg and return if status == :success
  puts 'x '.red + msg and return if status == :error
  puts 'i '.yellow + msg and return if status == :warn
end

def is_current?(start_str, end_str)
  start_date = Date.parse(start_str)
  end_date = Date.parse(end_str)

  start_date <= Date.today && Date.today <= end_date
end

def get_recurring_value(cal)
  days = []
  days << 'mon' if cal.monday == '1'
  days << 'tue' if cal.tuesday == '1'
  days << 'wed' if cal.wednesday == '1'
  days << 'thu' if cal.thursday == '1'
  days << 'fri' if cal.friday == '1'
  days << 'sat' if cal.saturday == '1'
  days << 'sun' if cal.sunday == '1'
  { days: days }
end

def get_direction(trip)
  json = JSON.parse(trip.to_json)
  json['direction_name'][0]
end

remote_uri = 'http://www.gonctd.com/google_transit.zip'
filename = 'data.zip'

unless File.file?(filename) && file = File.open("lib/data/#{filename}")
  tempfile = Tempfile.new(filename).tap do |file|
    file.binmode
    friendly_put('Downloading ' + remote_uri + ' to ' + file.path, :warn)
    file.write(open(remote_uri).read)
    file.close
    friendly_put 'Done!'
  end
  file = File.open(tempfile)
end
friendly_put "Importing #{file.path}"
source = GTFS::Source.build(file, {strict: false})

# INVALID!!!!!!!!!!!!!!!!!!!
# stations = source.stops.find_all {|s| s.location_type == '1' }
# INVALID!!!!!!!!!!!!!!!!!!!!
coaster_route = source.routes.find {|r| r.type == '2'}

# stations.each do |station|
#   station_record = Station.find_or_create_by(name: station.name) do |new_station|
#     new_station.geolocation = Geolocation.create(latitude: station.lat, longitude: station.lon)
#   end
#   friendly_put 'Station: ' + station_record.name
# end
# friendly_put 'Done creating stations'


friendly_put 'Parsing all stops... (this may take a while)', :warn
# fetch all coaster trips
trips = source.trips.find_all {|t| t.route_id == coaster_route.id }
trips.each do |trip|
  # check trips whose calendar dates are valid
  calendar = source.calendars.find {|c| c.service_id == trip.service_id }
  # skip unless the calendar is current
  next unless is_current?(calendar.start_date, calendar.end_date)


  # fetch stop times for this current trip
  stop_times = source.stop_times.find_all {|st| st.trip_id == trip.id }

  # DEBUG!
  # trip_idz << t.id.split(//).last(3).join
  # puts "VALID TRIP::"
  # puts t.inspect
  # puts "start_date: #{Date.parse(calendar.start_date)}  - end_date: #{Date.parse(calendar.end_date)}"
  # puts calendar.inspect
  # /DEBUG

  stop_times.each do |st|
    stop_station = source.stops.find {|s| s.id == st.stop_id }

    station_record = Station.find_or_create_by(name: stop_station.name) do |new_station|
      new_station.geolocation = Geolocation.create(latitude: stop_station.lat, longitude: stop_station.lon)
    end
    
    # VALID TRIP::
#<GTFS::Trip:0x007fa1cb0d1e88 @bikes_allowed="2", @route_id="398", @wheelchair_accessible="1", @direction_id="0", @headsign_short="Oceanside", @headsign="Oceanside", @block_id="b_39802", @shape_id="398_0_5", @service_id="C_SASCHoff_merged_11487280", @id="11383779", @direction_name="North">
# start_date: 2016-06-05  - end_date: 2016-08-20
#<GTFS::Calendar:0x007fa1c6141238 @service_id="C_SASCHoff_merged_11487280", @start_date="20160605", @end_date="20160820", 
# @monday="0", @tuesday="0", @wednesday="0", @thursday="0", @friday="0", @saturday="1", @sunday="0">
# CURRENT STOP STATION
#<GTFS::Stop:0x007fa1bc072d20 @intersection_code=nil, @lat="32.7175114861", @wheelchair_boarding="0", @code="28007", @lon="-117.170089506", @id="28007", @name_short="San Diego - Santa Fe Depot", @parent_station=nil, @name="San Diego - Santa Fe Depot", @reference_place=nil, @location_type="0", @place="CSTSDS", @zone_id="C7">
# CURRENT STOP INFORMATIONZ
#<GTFS::StopTime:0x007fa1b72326d8 @trip_id="11383779", @arrival_time="16:56:00", @departure_time="16:56:00", @stop_id="28007", @stop_sequence="1", @stop_headsign=nil, @pickup_type=nil, @drop_off_type=nil, @shape_dist_traveled=nil, @timepoint=nil>
    begin
      train = Train.create(
          name: trip.id.split(//).last(3).join,
          departure_time: Time.parse(st.departure_time).strftime("%I:%M%p"),
          direction: get_direction(trip),
          station_id: station_record.id,
          completed: false,
          recurring: true,
          recurring_value: get_recurring_value(calendar)
        )
      friendly_put "Created train: #{train.name}"
    rescue StandardError => e
      friendly_put "ERROR! #{e.message}", :error
      friendly_put st.inspect, :error
    end
  end
end



# puts "TRIP IDZ"
# puts trip_idz
# Amtrak trains for Coaster service:
# 567/1567, 573, 595, 784, 790/1790, 796

# source.agencies
# source.stops
# source.routes
# source.trips
# source.stop_times
# source.calendars
# source.calendar_dates     
# source.fare_attributes    
# source.fare_rules         
# source.shapes
# source.frequencies        
# source.transfers