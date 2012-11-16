class Zone < ActiveRecord::Base
  attr_accessible :name
  has_many :stations

  def self.second
  	Zone.find(2)
  end
end
