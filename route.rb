class Route
  attr_reader :all_stations

  def initialize(start_station, end_station)
    @all_stations = [start_station, end_station]
  end

  def add_intermediate_station(station)
    @all_stations.insert(@all_stations.length - 1, station)
  end

  def remove_intermediate_station(station)
    @all_stations.delete(station)
  end

  def list_all_stations
    @all_stations.each { |station| puts station }
  end
end
