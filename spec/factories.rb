require 'ipaddr'

FactoryGirl.define do
  factory :user do
    name 'Lazslo'
    email 'lazslo@dmail.com'
    password 'imadog'
    password_confirmation 'imadog'
    ip_address { IPAddr.new(10 * 2**24 + rand(2**24), Socket::AF_INET).to_s }
  end

  factory :station do
    address '1050 Kettner Blvd.'
    city 'San Diego'
    name 'Santa Fe Depot (San Diego)'
    state 'CA'
    zip '92101'
    zone_id 3
  end

  factory :train do
    name '808'
    departure_time { Time.now }
    direction 'N'
    station { Station.find_by(name: 'Santa Fe Depot (San Diego)') }
    recurring true
    completed false
    recurring_value { { days: %w(mon tue wed thu fri sat sun) } }
    next_date nil
  end

  factory :destination do
    name 'A place'
    address1 '123 aplace ave'
    address2 ''
    city 'A City'
    state 'A State'
    zip '12345'
    user_id ''
  end
end
