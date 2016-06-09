require 'spec_helper'
require 'rails_helper'

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  remember_token  :string(255)
#  password_digest :string(255)
#  profile         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE)
#  ip_address      :string(255)
#  tracking        :boolean          default(FALSE)
#

describe User, :type => :model do

  before do
    @user = FactoryGirl.create :user
  end

  it "has expected attributes" do
    expect(@user).to have_attributes(name: "Lazslo",
                                     email: "lazslo@dmail.com",
                                     password: "imadog",
                                     password_confirmation: "imadog",
                                     password_digest: /\A\S{60}\z/,
                                     remember_token: /\A\S{22}\z/)
    expect(User.find_by(name: "Lazslo"))
  end
end
