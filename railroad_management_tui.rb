# frozen_string_literal: true

require_relative 'train_management'
require_relative 'route_management'
require_relative 'station_management'

class RailroadManagementTui
  attr_reader :train_manager, :route_manager, :station_manager

  def initialize
    @train_manager = TrainManagement.new(self)
    @route_manager = RouteManagement.new(self)
    @station_manager = StationManagement.new(self)
  end

  def tui
    open_menu(self, :general_info, ACTIONS_GENERAL)
  end

  private

  def open_menu(object, message, actions)
    while true
      puts MESSAGES[message]
      user_input = gets.chomp.to_i

      # Open general menu if user chooses to go back from
      # sub-menus
      tui if user_input == actions.length

      return if user_input.negative?
      return if user_input > actions.length

      object.send(actions[user_input])
    end
  end

  MESSAGES = {
    general_info: "Welcome!\n"\
                  "--------\n"\
                  "To open route management press 0\n"\
                  "To open train mangement press 1\n"\
                  "To open station management press 2\n"\
                  'To exit press 3',

    route_management_info: "Route management\n"\
                           "----------------\n"\
                           "To create new route press 0\n"\
                           'To add intermediate station to'\
                             "existing route press 1\n"\
                           'To remove intermediate stations from'\
                             "existing route press 2\n"\
                           "To list all routes press 3\n"\
                           'To go back press 4',

    train_management_info: "Train management\n"\
                           "----------------\n"\
                           "To create new train press 0\n"\
                           "To create new carriage press 1\n"\
                           "To set existing route for the train press 2\n"\
                           "To add new carriages to the train press 3\n"\
                           "To remove carriages from the train press 4\n"\
                           "To traverse train forward press 5\n"\
                           "To traverse train backward press 6\n"\
                           "To list all trains press 7\n"\
                           'To go back press 8',

    station_management_info: "Station management\n"\
                             "------------------\n"\
                             "To create new station input 0\n"\
                             "To list all stations input 1\n"\
                             'To go back press 2'
  }.freeze

  def route_management_menu
    puts ''
    open_menu(route_manager, :route_management_info, ACTIONS_ROUTE_MANAGEMENT)
  end

  def train_management_menu
    puts ''
    open_menu(train_manager, :train_management_info, ACTIONS_TRAIN_MANAGEMENT)
  end

  def station_management_menu
    puts ''
    open_menu(station_manager, :station_management_info,
              ACTIONS_STATION_MANAGEMENT)
  end

  def terminate_manager
    puts 'Goodbye, have a nice day!'
    exit(true)
  end

  ACTIONS_GENERAL = [:route_management_menu,
                     :train_management_menu,
                     :station_management_menu,
                     :terminate_manager].freeze

  ACTIONS_ROUTE_MANAGEMENT = [:new_route,
                              :add_station,
                              :remove_station,
                              :list_routes].freeze

  ACTIONS_TRAIN_MANAGEMENT = [:new_train,
                              :new_carriage,
                              :set_route,
                              :add_carriage,
                              :remove_carriage,
                              :traverse_forward,
                              :traverse_backward,
                              :list_trains].freeze

  ACTIONS_STATION_MANAGEMENT = [:new_station,
                                :list_stations].freeze
end
