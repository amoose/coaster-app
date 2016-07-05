class AddStationIdToTrains < ActiveRecord::Migration
  def change
    add_column :trains, :station_id, :integer
  end
end
