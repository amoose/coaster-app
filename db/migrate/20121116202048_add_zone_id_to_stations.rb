class AddZoneIdToStations < ActiveRecord::Migration
  def change
  	add_column :stations, :zone_id, :integer
  end
end
