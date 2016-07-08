# == Schema Information
#
# Table name: stations
#
#  id         :integer          not null, primary key
#  name       :string
#  city       :string
#  state      :string
#  zip        :string
#  created_at :datetime
#  updated_at :datetime
#  address    :string
#  zone_id    :integer
#

require 'test_helper'

class StationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
