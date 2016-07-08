# == Schema Information
#
# Table name: geolocations
#
#  id               :integer          not null, primary key
#  latitude         :float
#  longitude        :float
#  address          :string
#  geocodeable_id   :integer
#  geocodeable_type :string
#  created_at       :datetime
#  updated_at       :datetime
#  accuracy         :integer
#  gmaps            :boolean
#

require 'test_helper'

class GeolocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
