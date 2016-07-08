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

require 'test_helper'

class DestinationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
