def friendly_put(msg, status = :success)
  puts '✓ '.green + msg and return if status == :success
  puts 'x '.red + msg and return if status == :error
  puts 'i '.yellow + msg and return if status == :warn
end

def current?(start_str, end_str)
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
