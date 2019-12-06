class CreatePlaceGeos < ActiveRecord::Migration[5.2]
  def change
    create_table :place_geos do |t|
      t.string :geohash

      t.timestamps
    end

    ActiveRecord::Base.connection.execute("
      ALTER TABLE place_geos
      ADD COLUMN `geopoint` POINT SRID 3857
      AFTER `geohash`;
    ")
  end
end
