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
#

class Geolocation < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  belongs_to :geocodeable, :polymorphic => true
  geocoded_by :address, :if => :address_changed?
  after_validation :geocode
end
