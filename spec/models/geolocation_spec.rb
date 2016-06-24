require 'spec_helper'
require 'rails_helper'

describe Geolocation, type: :model do
  before do
    @geolocation = FactoryGirl.create(:station).geolocation
  end
  context 'with an address' do
    it 'returns appropriate short address' do
      expect(@geolocation.short_address).to eq('1050 Kettner Blvd.,  San Diego')
    end
  end

  context 'without an address' do
    it 'returns latitude and longitude' do
      @geolocation.address = nil
      expect(@geolocation.short_address).to eq("32.7166066, -117.1695229")
    end
  end

  it 'verifies changes in lat or lng' do
    expect(@geolocation.latlon_changed?).to be_falsey
    @geolocation.latitude = 34.2349082349
    expect(@geolocation.latlon_changed?).to be_truthy
  end

end
