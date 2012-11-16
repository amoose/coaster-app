class Geolocation < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  belongs_to :geocodeable, :polymorphic => true
  geocoded_by :address, :if => :address_changed?
  after_validation :geocode
end
