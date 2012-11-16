class AddGeocodeable < ActiveRecord::Migration
  def up
  	add_column :geolocations, :geocodeable_id, :integer
  	add_column :geolocations, :geocodeable_type, :string
  end

  def down
  	remove_column :geolocations, :geocodeable_id
  	remove_column :geolocations, :geocodeable_type
  end
end
