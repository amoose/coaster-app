class Zone < ActiveRecord::Base
  attr_accessible :name
  has_many :stations
end
