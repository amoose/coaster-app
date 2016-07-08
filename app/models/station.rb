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
  has_one :geolocation, as: :geocodeable, dependent: :destroy
  has_many :trains
  before_save :set_geolocation
  reverse_geocoded_by :lat, :lon
  after_validation :reverse_geocode

  def full_address
    address + ', ' + city + ', ' + zip
  end

  def set_geolocation
    self.geolocation ||= Geolocation.new(address: full_address)
  end

  def departing(date = Date.today)
    # self.trains.each do |train|
    #   [] << train if train.departs?(date)
    # end
    trains.select { |train| train.departs?(date) }
  end

  private

  def lat
    geolocation.latitude if geolocation
  end

  def lon
    geolocation.longitude if geolocation
  end
end
