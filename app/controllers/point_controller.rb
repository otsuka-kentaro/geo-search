class PointController < ApplicationController
  def index
    @duration = nil
    ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)

      @duration = event.duration if event.payload[:name] == 'PlaceGeo Load'
    end

    @places = PlaceGeo.find_by_point_by_distance(35.712678, 139.761989, 0.009).select_lat_lon.to_a
  end
end
