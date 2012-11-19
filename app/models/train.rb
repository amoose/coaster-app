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

class Train < ActiveRecord::Base
  attr_accessible :departure_time, :direction, :name, :wifi, :station
  belongs_to :station


end
