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

  private

  def trains_on_station(station)
    return 'No trains' if station.trains.empty?

    res = ''
    station.trains.each { |train| res += train.id + ' ' }

    res
  end
end
