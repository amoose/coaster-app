require 'spec_helper'
require 'rails_helper'

describe StaticPagesController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @station = FactoryGirl.create(:station)
  end

  describe 'GET home' do
    it 'gets home' do
      new_session

      get :home
      expect(response).to be_ok
    end

    it 'finds nearby stations' do
      skip 'Must give appropriate IP address to geocoder'
    end
  end
end
