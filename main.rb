class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select do |train|
      train.type == type
    end
  end

  def send_train
    @trains.pop
  end
end

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

class Train
  attr_reader :velocity, :carriage_num, :type

  def initialize(id, type, carriage_num)
    @id = id
    @type = type
    @carriage_num = carriage_num

    @velocity = 0
  end

  def accelerate_by(delta_velocity)
    @velocity += delta_velocity
  end

  def stop
    @velocity = 0
  end

  def add_carriage
    if not @velocity
      @carriage_num += 1
    end
  end

  def remove_carriage
    if not @velocity and @carriage_num
      @carriage_num -= 1
    end
  end

  def set_route(route)
    @route = route
    @cur_station_index = 0
    @route_length = @route.all_stations.length
    @route.all_stations[@cur_station_index].receive_train(self)
  end

  def traverse_next_station
    # If the route is actually set
    if not @route.nil?
      # Then send train from the current station
      @route.all_stations[@cur_station_index].send_train
      @cur_station_index += 1
      @cur_station_index %= @route_length
      # And receive it on the next station
      @route.all_stations[@cur_station_index].receive_train(self)
    end
  end

  def traverse_prev_station
    if not @route.nil?
      @route.all_stations[@cur_station_index].send_train
      @cur_station_index -= 1
      @cur_station_index %= @route_length
      @route.all_stations[@cur_station_index].receive_train
    end
  end

  def get_cur_station
    @route.all_stations[@cur_station_index]
  end

  def get_prev_station
    @route.all_stations[(@cur_station_index - 1) % @route_length]
  end

  def get_next_station
    @route.all_stations[(@cur_station_index + 1) % @route_length]
  end
end

station1 = Station.new("station1")
station2 = Station.new("station2")
station3 = Station.new("station3")
station4 = Station.new("station4")
station5 = Station.new("station5")

# Make route st1 -> st2 -> st3 -> st4 -> st5
route = Route.new(station1, station5)
route.add_intermediate_station(station2)
route.add_intermediate_station(station3)
route.add_intermediate_station(station4)

# Make train
train = Train.new(123, "passenger", 10)
train.set_route(route)
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name
 
train.traverse_next_station
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name

# We are currently on station1
puts "There are passenger trains on station1" if not station1.trains_by_type("passenger").empty?
puts "There are cargo trains station 1" if not station1.trains_by_type("cargo").empty?

puts "There are passenger trains on station2" if not station2.trains_by_type("passenger").empty?
puts "There are cargo trains station 2" if not station2.trains_by_type("cargo").empty?
