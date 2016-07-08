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
  belongs_to :station
  serialize :recurring_value, Hash

  def self.active
    Train.where(:completed => false)
  end

  def next_departure(date=Date.today)
    # if self.departs? only works if date=Date.today
    if self.departs?(date)
			self.departure
    end
  end

  def departs?(date=Date.today)
  	recurring and recurring_value.has_key?(:days) and recurring_value[:days].include? Date::ABBR_DAYNAMES[date.wday].downcase
  end

  def has_departed?(time=Time.zone.now)
  	departure > time
  end

  def formatted_time
    departure_time.strftime('%r')
	end

	def departure(date=Date.today)
		time_today if departs?(date)
	end

  private

  def time_today(date=Date.today)
    time = departure_time.in_time_zone('Pacific Time (US & Canada)')
    Time.mktime(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end
end
