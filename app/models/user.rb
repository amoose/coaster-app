# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  remember_token  :string
#  password_digest :string
#  profile         :text
#  created_at      :datetime
#  updated_at      :datetime
#  admin           :boolean          default("false")
#  ip_address      :string
#  tracking        :boolean          default("false")
#

class User < ActiveRecord::Base
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  before_save :set_geolocation

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: :should_validate_password?
  validates :password_confirmation, presence: true, if: :should_validate_password?

  has_one :geolocation, as: :geocodeable, dependent: :destroy

  has_many :destinations, dependent: :destroy

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def set_geolocation
    geolocation.destroy unless geolocation.nil?
    self.geolocation = Geolocation.new(address: ip_address, accuracy: 9)
  end

  def should_validate_password?
    new_record? || !password.nil? && !password_confirmation.nil?
  end
end
