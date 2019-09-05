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
      @route.all_stations[@cur_station_index].send_train(self)
      @cur_station_index += 1
      @cur_station_index %= @route_length
      # And receive it on the next station
      @route.all_stations[@cur_station_index].receive_train(self)
    end
  end

  def traverse_prev_station
    if not @route.nil?
      @route.all_stations[@cur_station_index].send_train(self)
      @cur_station_index -= 1
      @cur_station_index %= @route_length
      @route.all_stations[@cur_station_index].receive_train(self)
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
