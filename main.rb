# frozen_string_literal: true

require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'railroad_management_tui'

railroad_manager = RailroadManagementTui.new
railroad_manager.tui
