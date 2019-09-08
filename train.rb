class Train
  attr_reader :velocity, :carriage_num, :type

  def initialize(id, type, carriage_num)
    @id = id
    @type = type
    @carriages = []

    @velocity = 0
  end

  def engine_stopped?
    @velocity.zero?
  end

  def accelerate_by(delta_velocity)
    @velocity += delta_velocity
  end

  def decrease_speed(delta_velocity)
    return if (@velocity - delta_velocity).negative?

    @velocity -= delta_velocity unless engine_stopped?
  end

  def add_carriage(carriage)
    @carriages << carriage if engine_stopped?
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if engine_stopped?
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    current_station.receive_train(self)
  end

  def traverse_next_station
    # If the route is actually set
    if @route
      # Then send train from the current station
      current_station.send_train(self)
      @current_station_index += 1
      # And receive it on the next station
      current_station.receive_train(self)
    end
  end

  def traverse_prev_station
    if @route
      current_station.send_train(self)
      @current_station_index -= 1
      current_station.receive_train(self)
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end
end
