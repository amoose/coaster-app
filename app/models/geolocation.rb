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
  	begin
  		address ||= fetch_address
  	rescue
  		return "wut"
  	end
  end

  def short_address
  	begin
	  	adr_short = ''
	  	adr = address.split(",").values_at(0..1)
	  	"#{adr[0]}, #{adr[1]}"
	  rescue
	  	begin
	  		"#{latitude}, #{longitude}"
	  	rescue
	  		"Unknown"
	  	end
	  end
	end

  def latlon_changed?
  	if self.latitude != Geolocation.find(self.id).latitude or self.longitude != Geolocation.find(self.id).longitude
  		return true
  	else
  		return false
  	end
  end
end
