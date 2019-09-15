# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Train
  attr_reader :velocity, :type, :id
  include ManufacturerCompany
  include InstanceCounter

  class << self
    attr_accessor :all_trains
  end

  def initialize(id, type)
    @id = id
    @type = type
    @carriages = []

    @velocity = 0

    self.class.all_trains ||= []
    self.class.all_trains << self

    register_instance
  end

  def engine_stopped?
    @velocity.zero?
  end

  def number_carriages
    @carriages.length
  end

  def accelerate_by(delta_velocity)
    @velocity += delta_velocity
  end

  def decrease_speed(delta_velocity)
    return if (@velocity - delta_velocity).negative?

    @velocity -= delta_velocity unless engine_stopped?
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

  def self.find(id)
    return if @all_trains.nil?

    @all_trains.find { |train| train.id == id }
  end

  protected

  attr_reader :carriages

  def add_carriage(carriage)
    @carriages << carriage if engine_stopped?
  end
end
