class Station < ActiveRecord::Base
  attr_accessible :address, :city, :name, :state, :zip
  belongs_to :zone
  has_one :geolocation, :as => :geocodeable
end
