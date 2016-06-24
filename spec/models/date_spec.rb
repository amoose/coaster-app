require './app/models/date.rb'
require 'spec_helper'
require 'rails_helper'

describe Date, type: :model do
  it 'returns appropriate dayname' do
    expect("2016-06-24 15:43:06 -0700".to_datetime.dayname).to eq('Friday')
  end

  it 'returns appropriate abbreviated dayname' do
    expect("2016-06-24 15:43:06 -0700".to_datetime.abbr_dayname).to eq('Fri')
  end
end
