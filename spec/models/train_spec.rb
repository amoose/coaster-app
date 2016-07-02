require 'spec_helper'
require 'rails_helper'

describe Train, type: :model do
  before do
    @train = FactoryGirl.create(:train)
    @train2 = FactoryGirl.create(:train, recurring_value: {"days" =>['mon']})
    @date = "Sun, 12 Jun 2016".to_date

  end

  it 'returns next departure on given date' do
    expect(@train.next_departure(@date).to_s).to include("2016-06-13")
    expect(@train2.next_departure(@date)).to eq(nil)
  end

  it 'checks to see if train departs on given date' do
    expect(@train.departs?(@date)).to be_truthy
    expect(@train2.departs?(@date)).to be_falsey
  end

  it 'returns departure time in Pacific Time' do
    skip
  end
end
