# frozen_string_literal: true

class Station
  attr_reader :trains, :name
  @all_stations = []

  class << self
    attr_accessor :all_stations
  end

  def initialize(name)
    @name = name
    @trains = []

    self.class.all_stations << self
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
end
