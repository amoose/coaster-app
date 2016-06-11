require 'ipaddr'

FactoryGirl.define do
  factory :user do
    name "Lazslo"
    email "lazslo@dmail.com"
    password "imadog"
    password_confirmation "imadog"
    ip_address {IPAddr.new(10*2**24 + rand(2**24),Socket::AF_INET).to_s}
  end

  factory :station do
    address "756 street lane park"
    city "some city"
    name "some city station"
    state "QW"
    zip "55555"
    zone_id 7
  end

  factory :train do
    name "808"
    departure_time {Time.now}
    direction "N"
    station {Station.find_by(name: "some city station")}
    recurring true
    completed false
    recurring_value {{"days"=>["mon", "tue", "wed", "thu", "fri", "sat", "sun"], next_date: nil}}
  end

  factory :destination do
    name "A place"
    address1 "123 aplace ave"
    address2 ""
    city "A City"
    state "A State"
    zip "12345"
    user_id ""

  end
end


