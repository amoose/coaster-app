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

class Station < ActiveRecord::Base
  # attr_accessible :address, :city, :name, :state, :zip, :zone
  belongs_to :zone
  has_one :geolocation, :as => :geocodeable, dependent: :destroy
  has_many :trains
  before_save :set_geolocation
  reverse_geocoded_by :get_lat, :get_lon
  after_validation :reverse_geocode

  def full_address
    address = self.address + ', ' + city + ', ' + zip
  end

  def set_geolocation
    self.geolocation ||= Geolocation.new(address: full_address)
  end

<<<<<<< 383da8294493be95152025f16bf836541406797b
  def departing(date=Date.today)
=======
  # def self.near

  # end

  def departing(date = Date.today)
>>>>>>> Rubocop first run
    # self.trains.each do |train|
    #   [] << train if train.departs?(date)
    # end
    trains.select { |train| train.departs?(date) }
  end

  private

  def get_lat
    geolocation.latitude if geolocation
  end

  def get_lon
    geolocation.longitude if geolocation
  end
end
