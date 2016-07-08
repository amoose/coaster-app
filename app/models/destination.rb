# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  name       :string
#  address1   :string
#  address2   :string
#  city       :string
#  state      :string
#  zip        :string
#  user_id    :integer
#  photo      :string
#  created_at :datetime
#  updated_at :datetime
#

class Destination < ActiveRecord::Base
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
