# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validator'

class Route
  attr_reader :stations, :name
  include InstanceCounter
  include Validator

  def initialize(start_station, end_station, name)
    @stations = [start_station, end_station]
    @name = name

    validate!
    register_instance
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
  end

  def remove_intermediate_station(station)
    unless station == @stations[0] or station == @stations[-1]
      @stations.delete(station)
    end
  end

  def list_all_stations
    @stations.each { |station| puts station.name }
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  private

  def validate!
    raise "Name cannot be empty" if name.empty?
  end
end
