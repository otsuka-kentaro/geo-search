class PlaceGeo < ApplicationRecord
  scope :select_lat_lon, -> {
    select('ST_Y(geopoint) AS lat, ST_X(geopoint) AS lon')
  }

  # distance: 0.009 で 1km くらい
  def self.find_by_point_by_distance(lat, lon, distance)
    where(
      'ST_Within(geopoint, ST_Srid(ST_Buffer(POINT(?, ?), ?), 3857))',
      lon, lat, distance
    )
  end
end
