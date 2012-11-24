# == Schema Information
#
# Table name: geolocations
#
#  id               :integer          not null, primary key
#  latitude         :float
#  longitude        :float
#  address          :string(255)
#  geocodeable_id   :integer
#  geocodeable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  accuracy         :integer
#

class Geolocation < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :accuracy
  belongs_to :geocodeable, :polymorphic => true
  geocoded_by :address, :if => :address_changed?
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def address
  	address ||= fetch_address
  end

  def short_address
  	adr_short = ''
  	adr = address.split(",").values_at(0..1)
  	"#{adr[0]}, #{adr[1]}"
  end
end
