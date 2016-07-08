# == Schema Information
#
# Table name: trains
#
#  id              :integer          not null, primary key
#  name            :string
#  departure_time  :time
#  direction       :string
#  wifi            :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  station_id      :integer
#  recurring       :boolean          default("false")
#  completed       :boolean          default("false")
#  recurring_value :text
#  next_date       :datetime
#

require 'test_helper'

class TrainTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
