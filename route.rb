class Route
  attr_reader :all_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station

    @intermediate_stations = []
    @all_stations = [@start_station, @end_station]
  end

  def add_intermediate_station(station)
    @intermediate_stations << station
    @all_stations = [@start_station] + @intermediate_stations + [@end_station]
  end

  def remove_intermediate_station(station)
    if @intermediate_stations.include? station
      @intermediate_stations.delete station
      @all_stations = [@start_station] + @intermediate_stations + [@end_station]
    end
  end

  def list_all_stations
    self.all_stations.each do |station|
      puts station
    end
  end
end
