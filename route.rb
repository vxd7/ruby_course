class Route
  attr_reader :all_stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def remove_intermediate_station(station)
    @stations.delete(station)
  end

  def list_all_stations
    @stations.each { |station| puts station }
  end
end
