# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validator'

class Station
  attr_reader :trains, :name
  include InstanceCounter
  include Validator

  @all_stations = []

  class << self
    attr_accessor :all_stations
  end

  def initialize(name)
    @name = name
    @trains = []

    validate!
    self.class.all_stations << self
    register_instance
  end

  def receive_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    all_stations
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  def each_train(&block)
    @trains.each { |train| block.call(train) if block_given? }
  end

  private

  def validate!
    raise "Name cannot be empty" if name.empty?
  end
end
