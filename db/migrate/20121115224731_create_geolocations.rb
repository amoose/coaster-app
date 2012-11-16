class CreateGeolocations < ActiveRecord::Migration
  def change
    create_table :geolocations do |t|
      t.float :latitude
      t.float :longitude
      t.address :string

      t.references :geocodeable, :polymorphic => true
      t.timestamps
    end
  end
end
