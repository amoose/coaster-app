# == Schema Information
#
# Table name: trains
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  departure_time :time
#  direction      :string(255)
#  wifi           :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  station_id     :integer
#

require 'test_helper'

class TrainTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
