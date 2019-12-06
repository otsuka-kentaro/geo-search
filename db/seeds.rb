# 1行目 (日本あたりに座標を自動生成)
# latitude value is out of range in 'st_geohash'
# 何故か lat, lon の順序が逆
geohash = 'ST_GeoHash(POINT(129.339 + 16.151 * RAND(), 30.591 + 14.7212 * RAND()), 12)'
ActiveRecord::Base.connection.execute("
  INSERT INTO place_geos (geohash, created_at, updated_at)
  SELECT #{geohash}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
")

place_sql = "
  INSERT INTO place_geos (geohash, created_at, updated_at)
  SELECT #{geohash}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
  FROM place_geos
"

pp '2行'
ActiveRecord::Base.connection.execute(place_sql)
pp '4行'
ActiveRecord::Base.connection.execute(place_sql)
pp '8行'
ActiveRecord::Base.connection.execute(place_sql)
pp '16行'
ActiveRecord::Base.connection.execute(place_sql)
pp '32行'
ActiveRecord::Base.connection.execute(place_sql)
pp '64行'
ActiveRecord::Base.connection.execute(place_sql)
pp '128行'
ActiveRecord::Base.connection.execute(place_sql)
pp '256行'
ActiveRecord::Base.connection.execute(place_sql)
pp '512行'
ActiveRecord::Base.connection.execute(place_sql)
pp '512行'
ActiveRecord::Base.connection.execute(place_sql)
pp '2,048行'
ActiveRecord::Base.connection.execute(place_sql)
pp '4,096行'
ActiveRecord::Base.connection.execute(place_sql)
pp '8,192行'
ActiveRecord::Base.connection.execute(place_sql)
pp '16,384行'
ActiveRecord::Base.connection.execute(place_sql)
pp '32,768行'
ActiveRecord::Base.connection.execute(place_sql)
pp '65,536行'
ActiveRecord::Base.connection.execute(place_sql)
pp '131,072行'
ActiveRecord::Base.connection.execute(place_sql)
pp '262,144行'
ActiveRecord::Base.connection.execute(place_sql)
pp '524,288行'
ActiveRecord::Base.connection.execute(place_sql)
pp '1,048,576行'
ActiveRecord::Base.connection.execute(place_sql)
pp '2,097,152行'
ActiveRecord::Base.connection.execute(place_sql)
pp '4,194,304行'
ActiveRecord::Base.connection.execute(place_sql)

pp 'update geopoint'
ActiveRecord::Base.connection.execute("UPDATE place_geos SET geopoint = ST_PointFromGeoHash(`geohash`, 3857)")

pp '良くないけど seed 後に index 追加'
ActiveRecord::Base.connection.execute("
  ALTER TABLE place_geos MODIFY COLUMN `geopoint` POINT SRID 3857 NOT NULL;
")
pp 'add spatial index'
ActiveRecord::Base.connection.execute("
  ALTER TABLE place_geos ADD SPATIAL INDEX(`geopoint`);
")
