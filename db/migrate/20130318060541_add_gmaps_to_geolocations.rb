class AddGmapsToGeolocations < ActiveRecord::Migration
  def change
  	add_column :geolocations, :gmaps, :boolean
  end
end
