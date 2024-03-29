# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'instance_counter'
# require_relative 'validator'
require_relative 'validation'
require_relative 'accessors'

class Train
  attr_reader :velocity, :type, :id
  include ManufacturerCompany
  include InstanceCounter
  # include Validator # valid?
  include Validation
  include Accessors

  # Three letters or numbers, optional minus sign and two letter or numbers
  ID_PATTERN = /^([a-zA-Z]|\d){3}\-{0,1}([a-zA-Z]|\d){2}$/.freeze

  validate :id, :presence
  validate :id, :format, ID_PATTERN

  class << self
    attr_accessor :all_trains
  end

  # Save history of routes and current_station_index
  attr_accessor_with_history :route, :current_station_index

  def initialize(id, type)
    @id = id
    @type = type
    @carriages = []

    @velocity = 0

    # Validate object first
    validate!

    # If object is valid, push it to
    # object hash
    self.class.all_trains ||= []
    self.class.all_trains << self

    # And register it
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

  def add_carriage(carriage)
    raise 'Invalid carriage' if carriage.nil?

    unless carriage.is_a?(Carriage)
      raise 'carriage to add must be an instance of Carriage'
    end

    @carriages << carriage if engine_stopped?
  end

  def remove_carriage(carriage)
    raise 'Invalid carriage' if carriage.nil?

    unless carriage.is_a?(Carriage)
      raise 'carriage to add must be an instance of Carriage'
    end

    @carriages.delete(carriage) if engine_stopped?
  end

  def set_route(route)
    raise 'Invalid route' if route.nil?
    raise 'route must be an instance if Route' unless route.is_a?(Route)

    self.route = route
    self.current_station_index = 0
    current_station.receive_train(self)
  end

  def traverse_next_station
    raise 'Route is not set!' if @route.nil?

    # Then send train from the current station
    current_station.send_train(self)
    self.current_station_index += 1
    # And receive it on the next station
    current_station.receive_train(self)
  end

  def traverse_prev_station
    raise 'Route is not set!' if @route.nil?

    current_station.send_train(self)
    self.current_station_index -= 1
    current_station.receive_train(self)
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

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  def each_carriage(&block)
    @carriages.each { |carriage| block.call(carriage) if block_given? }
  end

  protected

  attr_reader :carriages

  # private

  # def validate!
  #   raise 'Incorrect number of characters in train id' unless @id.length.between?(5, 6)
  #   raise 'Incorrect format of train id' unless @id =~ ID_PATTERN
  # end
end
