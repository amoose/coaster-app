# == Schema Information
#
# Table name: stations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address    :string(255)
#  zone_id    :integer
#

class Station < ActiveRecord::Base
  # attr_accessible :address, :city, :name, :state, :zip, :zone
  belongs_to :zone
  has_one :geolocation, :as => :geocodeable, dependent: :destroy
  has_many :trains
  before_save :set_geolocation

  def full_address
  	address = self.address + ', ' + self.city + ', ' + self.zip
  end

  def set_geolocation
  	self.geolocation ||= Geolocation.new(:address => self.full_address)
  end


  # def self.near

  # end

  def departing(date=Date.today)
    # self.trains.each do |train|
    #   [] << train if train.departs?(date)
    # end
    self.trains.select {|train| train.departs?(date)}
  end
end
