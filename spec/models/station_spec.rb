require 'spec_helper'
require 'rails_helper'

describe Station, type: :model do
  before do
    @station = FactoryGirl.create :station
  end

  it 'has a full address' do
    expect(@station.full_address).to eq("1050 Kettner Blvd., San Diego, 92101")
  end

  it 'sets a geolocation' do
    expect(@station.geolocation).not_to eq(nil)
  end

  it 'only lists trains departing on given date', focus: true do
    @train = FactoryGirl.create(:train)
    @train2 = FactoryGirl.create(:train, recurring_value: {"days" => ["mon"]})
    date = "Sun, 12 Jun 2016".to_date

    expect(@station.departing(date)).to include(@train)
    expect(@station.departing(date)).not_to include(@train2)
  end
end
