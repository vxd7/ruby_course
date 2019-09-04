class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def trains_by_type(type)
  end

  def send_train
    @trains.pop
  end
end

class Route
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station

    @intermediate_stations = []
  end

  def add_intermediate_station(station)
    @intermediate_stations << station
  end

  def remove_intermediate_station(station)
    if @intermediate_stations.include? station
      @intermediate_stations.delete station
    end
  end

  def list_all_stations
    all_stations = [@start_station] + @intermediate_stations + [@end_station]
    all_stations.each do |station|
      puts station
    end
  end

end

class Train
end
