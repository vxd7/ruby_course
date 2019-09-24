# frozen_string_literal: true

class StationManagement
  attr_reader :stations

  def initialize(railroad_manager)
    @stations = []
    @railroad_manager = railroad_manager
  end

  def new_station
    begin
      puts 'Pls input new station name:'
      station_name = gets.chomp

      new_station = Station.new(station_name)
    rescue StandardError => e
      puts 'There was an error while creating a new station'
      puts "The error was: #{e.message}"
      puts 'Please try again'
      retry
    end

    @stations << new_station
    puts "Station #{station_name} created successfully!"
  end

  def list_stations
    puts 'Avaliable stations:'
    @stations.each { |station| puts "Name: #{station.name}; Trains: #{trains_on_station(station)}" }
  end

  def list_trains_on_station
    station = find_station_tui
    if station.nil?
      puts 'Invalid station'
      return
    end

    station.each_train do |train|
      puts "Train: #{train.id}"
      puts "> type: #{train.type}"
      puts "> number of carriages: #{train.number_carriages}"
    end
  end

  private

  def trains_on_station(station)
    return 'No trains' if station.trains.empty?

    res = ''
    station.trains.each { |train| res += train.id + ' ' }

    res
  end

  def find_station_tui
    puts 'Pls input station name'
    station_name = gets.chomp

    @stations.find { |station| station.name == station_name }
  end
end
