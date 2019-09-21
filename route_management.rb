# frozen_string_literal: true

require_relative 'route'

class RouteManagement
  attr_reader :routes

  def initialize(railroad_manager)
    @routes = []
    @railroad_manager = railroad_manager
  end

  def list_routes
    return if @routes.empty?

    puts 'Avaliable routes'
    @routes.each do |route|
      puts "Route name: #{route.name}"
      puts '-----------'
      puts 'Stations in route:'
      route.stations.each { |station| puts "| #{station.name}" }
      puts ''
    end
  end

  def new_route
    # First list all avaliable stations
    @railroad_manager.station_manager.list_stations

    begin
      puts 'Pls input route name'
      route_name = gets.chomp

      puts 'Pls input starting station'
      start_station = search_station_tui

      puts 'Pls input end station'
      end_station = search_station_tui

      new_route = Route.new(start_station, end_station, route_name)
    rescue StandardError => e
      puts 'There was an error while constructing a new Route'
      puts "The error was: #{e.message}"
      puts 'Please try again'
      retry
    end

    @routes << new_route

    puts "New route #{route_name} starting at #{start_station.name} and ending at "\
         "#{end_station.name} has been successfully created!"
  end

  def add_station
    puts 'Please input information about the route'
    target_route = search_route_tui
    if target_route.nil? || !target_route.is_a?(Route)
      puts 'Incorrect target route! Cannot proceed'
      return
    end

    puts 'Now please input information about intermediate station'
    intermediate_station = search_station_tui

    target_route.add_intermediate_station(intermediate_station)
  rescue StandardError => e
    puts 'There was an error while adding intermediate station'
    puts "The error was: #{e.message}"
    puts 'Please try again'
    retry
  end

  def remove_station
    puts 'Please input information about the route'
    target_route = search_route_tui
    if target_route.nil? || !target_route.is_a?(Route)
      puts 'Incorrect target route! Cannot proceed'
      return
    end

    puts 'Now please input information about intermediate station'
    intermediate_station = search_station_tui

    target_route.remove_intermediate_station(intermediate_station)
  rescue StandardError => e
    puts 'There was an error while adding intermediate station'
    puts "The error was: #{e.message}"
    puts 'Please try again'
    retry
  end

  private

  def search_station_tui
    puts 'Pls input station name'
    station_name = gets.chomp

    @railroad_manager.station_manager.stations.find { |station| station.name == station_name }
  end

  def search_route_tui
    puts 'Pls input route name'
    route_name = gets.chomp

    @routes.find { |route| route.name == route_name }
  end
end
