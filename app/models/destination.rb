# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  user_id    :integer
#  photo      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Destination < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :name, :photo, :state, :user_id, :zip, :user
  has_one :geolocation, :as => :geocodeable
  before_save :set_geolocation
  belongs_to :user

  def long_address
  	address = self.address1 + ' ' + self.address2 + ', ' + self.city + ', ' + self.zip
  end

  def set_geolocation
  	self.geolocation ||= Geolocation.new(:address => self.long_address)
  end
end
