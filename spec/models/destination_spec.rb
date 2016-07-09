# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  name       :string
#  address1   :string
#  address2   :string
#  city       :string
#  state      :string
#  zip        :string
#  user_id    :integer
#  photo      :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'
require 'rails_helper'

describe Destination, type: :model do
  before do
    @destination = FactoryGirl.create(:destination)
  end

  it 'returns appropriate long address' do
    expect(@destination.long_address).to eq('123 aplace ave , A City, 12345')
  end

  it 'has a geolocation' do
    expect(@destination).to have_attributes(geolocation: Geolocation.find_by(address: @destination.long_address))
  end
end
