require File.expand_path('../../../lib/seed_helper.rb', __FILE__)
require 'csv'
require 'open-uri'
require 'colorize'

namespace :seed do
  desc "setup, create, migrate then seed the database"
  task :data => :environment do
    remote_uri = 'http://www.gonctd.com/google_transit.zip'
    filename = 'data.zip'

    unless File.file?(filename) && file = File.open("lib/data/#{filename}")
      tempfile = Tempfile.new(filename).tap do |file|
        friendly_put('Downloading ' + remote_uri + ' to ' + file.path, :warn)
        file.binmode
        file.write(open(remote_uri).read)
        file.close
      end
      file = File.open(tempfile)
    end
    friendly_put "Importing #{file.path}"
    source = GTFS::Source.build(file, {strict: false})

    # fetch coaster and sprinter routes
    # valid_routes = source.routes.find_all {|r| r.type == '2' || r.type == '0' }
    # just coaster routes
    valid_routes = source.routes.find_all {|r| r.type == '2' }

    friendly_put 'Parsing all stops... (this may take a while)', :warn
    trips = source.trips.find_all {|t| valid_routes.collect(&:id).include?(t.route_id) }

    trips.each do |trip|
      # check trips whose calendar dates are valid
      calendar = source.calendars.find {|c| c.service_id == trip.service_id }
      # skip unless the calendar is current
      next unless is_current?(calendar.start_date, calendar.end_date)

      # fetch stop times for this current trip
      stop_times = source.stop_times.find_all {|st| st.trip_id == trip.id }

      stop_times.each do |st|
        stop_station = source.stops.find {|s| s.id == st.stop_id }

        station_record = Station.find_or_create_by(name: stop_station.name) do |new_station|
          new_station.geolocation = Geolocation.create(latitude: stop_station.lat, longitude: stop_station.lon)
          friendly_put "Created #{stop_station.name} Station"
        end

        begin
          train = Train.find_or_create_by(
                name: trip.id,
                direction: get_direction(trip),
                station_id: station_record.id,
                completed: false
              ) do |t|
            t.recurring = true
            t.recurring_value = get_recurring_value(calendar)
            t.departure_time = Time.parse(st.departure_time + ' UTC').strftime("%I:%M%p")
          end
          friendly_put "Created train: #{train.name}"
        rescue StandardError => e
          friendly_put "ERROR! #{e.message}", :error
          friendly_put st.inspect, :error
        end
      end
    end
  end
end
