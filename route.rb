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
    raise 'Incorrect station' if station.nil?

    unless station.is_a?(Station)
      raise 'Intermediate station to insert '\
            'must be an instance of Station'
    end

    @stations.insert(-2, station)
  end

  def remove_intermediate_station(station)
    raise 'Incorrect station' if station.nil?

    unless station.is_a?(Station)
      raise 'Intermediate station to remove '\
            'must be an instance of Station'
    end

    if station == @statins.first || station == @stations.last
      raise 'Cannot remove starting or ending station from a route'
    end

    @stations.delete(station)
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
    raise 'Name cannot be empty' if name.empty?
    raise 'Incorrect starting station' if @stations.first.nil?
    raise 'Incorrect ending station' if @stations.last.nil?
    raise 'Starting station must be an instance of Station' unless @stations.first.is_a?(Station)
    raise 'Ending station must be an instance of Station' unless @stations.last.is_a?(Station)
  end
end
