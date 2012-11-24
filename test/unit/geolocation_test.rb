# == Schema Information
#
# Table name: geolocations
#
#  id               :integer          not null, primary key
#  latitude         :float
#  longitude        :float
#  address          :string(255)
#  geocodeable_id   :integer
#  geocodeable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  accuracy         :integer
#

require 'test_helper'

class GeolocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
