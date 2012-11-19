class Destination < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :name, :photo, :state, :user_id, :zip
  has_one :geolocation, :as => :geocodeable
  before_save :set_geolocation
  belongs_to :users1

  def full_address
  	address = self.address1 + self.address2 + ', ' + self.city + ', ' + self.zip
  end

  def set_geolocation
  	self.geolocation ||= Geolocation.new(:address => self.full_address)
  end
end