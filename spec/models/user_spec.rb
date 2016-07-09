require 'spec_helper'
require 'rails_helper'
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

describe User, type: :model do
  context 'with valid parameters' do
    before do
      @user = FactoryGirl.create :user
    end

    it 'has expected attributes' do
      expect(@user).to have_attributes(name: 'Lazslo',
                                       email: 'lazslo@dmail.com',
                                       password: 'imadog',
                                       password_confirmation: 'imadog',
                                       password_digest: /\A\S{60}\z/,
                                       remember_token: /\A\S{22}\z/)
      expect(User.find_by(name: 'Lazslo'))
    end

    it 'sets a geolocation' do
      expect(@user.geolocation).not_to eq(nil)
    end

    it 'creates a remember token' do
      expect(@user.remember_token).not_to eq(nil)
    end
  end

  context 'with password less than 6 characters' do
    it 'does not create a user' do
      expect(FactoryGirl.build(:user, password: 'foob',
                                      password_confirmation: 'foob')).not_to be_valid
    end
  end

  context 'with differing password confirmation' do
    it 'does not create a user' do
      expect(FactoryGirl.build(:user, password: 'foobar',
                                      password_confirmation: 'raboof')).not_to be_valid
    end
  end

  context 'with invalid email' do
    it 'does not create a user' do
      expect(FactoryGirl.build(:user, email: 'invalidemail')).not_to be_valid
    end
  end

  context 'with same email' do
    it 'does not create a user' do
      FactoryGirl.create(:user)
      expect(FactoryGirl.build(:user)).not_to be_valid
    end
  end
end
