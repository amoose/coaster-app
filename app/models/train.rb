require 'date'
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
  # attr_accessible :departure_time, :direction, :name, :wifi, :station, :recurring, :completed, :recurring_value
  belongs_to :station
  serialize :recurring_value, Hash

  def next_departure(date=Date.today)
    if self.departs?
			self.departure
    end
  end

  def departs?(date=Date.today)
  	self.recurring and self.recurring_value.has_key?('days') and self.recurring_value['days'].include? Date::ABBR_DAYNAMES[date.wday].downcase
  end

  def has_departed?(time=Time.now)
  	self.departure > time
  end

  def time_zone(date=Date.today)
  	time = self.departure_time.in_time_zone('Pacific Time (US & Canada)')
    Time.mktime(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end

  def formatted_time(time=self.time_zone)
		if time.strftime('%I').to_i < 10
			"#{time.strftime('%I').to_s[-1..-1]}#{time.strftime(':%M%p')}"
		else
			 time.strftime("%I:%M%p")
		end
	end

	def departure(date=Date.today)
		self.time_zone if self.departs?(date)
	end

  def self.active
  	Train.where(:completed => false)
	end


end
