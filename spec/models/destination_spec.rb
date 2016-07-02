require 'spec_helper'
require 'rails_helper'

describe Destination, type: :model do
  before do
    @destination = FactoryGirl.create(:destination)
  end

  it 'returns appropriate long address' do
    expect(@destination.long_address).to eq("123 aplace ave , A City, 12345")
  end

  it 'has a geolocation' do
    expect(@destination).to have_attributes(geolocation: Geolocation.find_by(address: @destination.long_address))
  end
end
