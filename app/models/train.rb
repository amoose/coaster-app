# == Schema Information
#
# Table name: trains
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  departure_time  :time
#  direction       :string(255)
#  wifi            :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  station_id      :integer
#  recurring       :boolean          default(FALSE)
#  completed       :boolean          default(FALSE)
#  recurring_value :text
#  next_date       :datetime
#

class Train < ActiveRecord::Base
  attr_accessible :departure_time, :direction, :name, :wifi, :station, :recurring, :completed, :recurring_value, :next_date
  belongs_to :station
  serialize :recurring_value, Hash

  def self.active
  	Train.where(:completed => false)
	end

end
