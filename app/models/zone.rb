# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Zone < ActiveRecord::Base
  # attr_accessible :name
  has_many :stations

  def self.second
    Zone.find(2)
  end
end
