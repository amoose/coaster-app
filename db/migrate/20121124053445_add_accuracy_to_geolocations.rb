class AddAccuracyToGeolocations < ActiveRecord::Migration
  def change
    add_column :geolocations, :accuracy, :integer
  end
end
