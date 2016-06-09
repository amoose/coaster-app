FactoryGirl.define do
  factory :user do
    name "Lazslo"
    email "lazslo@dmail.com"
    password "imadog"
    password_confirmation "imadog"
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
end


