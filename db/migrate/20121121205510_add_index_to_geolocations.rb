class AddIndexToGeolocations < ActiveRecord::Migration
  def change
    add_index :geolocations, [:latitude, :longitude]
  end
end
