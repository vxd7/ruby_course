# frozen_string_literal: true

class TrainManagement
  attr_reader :trains, :carriages

  def initialize(railroad_manager)
    @trains = []
    @carriages = []
    @railroad_manager = railroad_manager
  end

  private

  def find_train_tui
    puts 'Pls input train id'
    train_id = gets.chomp
    @trains.find { |train| train.id == train_id }
  end

  def find_route_tui
    puts 'Pls input route name'
    route_name = gets.chomp
    railroad_manager.route_manager.routes.find { |route| route.name == route_name }
  end

  def find_carriage_tui
    puts 'Pls input carriage id'
    carriage_id = gets.chomp
    @carriages.find { |carriage| carriage.id == carriage_id }
  end

  public

  def list_trains
    return if @trains.empty?

    puts 'Avaliable trains:'
    @trains.each do |train|
      puts "Id: #{train.id}; Type: #{train.type}; "\
           "# of carriages: #{train.number_carriages}"
    end
  end

  def new_train
    puts 'Pls input new train id'
    train_id = gets.chomp

    puts 'Pls input train type (passenger/cargo)'
    train_type = gets.chomp

    case train_type
    when 'passenger'
      new_train = PassengerTrain.new(train_id)
    when 'cargo'
      new_train = CargoTrain.new(train_id)
    end

    @trains << new_train
  end

  def new_carriage
    puts 'Pls input new carriage id:'
    carriage_id = gets.chomp

    puts "Pls input desired type for carriage #{carriage_id}"
    carriage_type = gets.chomp

    case carriage_type
    when 'passenger'
      new_carriage = PassengerCarriage.new(carriage_id)
    when 'cargo'
      new_carriage = CargoCarriage.new(carriage_id)
    end

    @carriages << new_carriage
  end

  def set_route
    target_train = find_train_tui
    return if target_train.nil?

    target_route = find_route_tui
    return if target_route.nil?

    target_train.set_route(target_route)
    puts "Successfully set route #{target_route.name} for"\
         "the train #{target_train.id}!"
  end

  def add_carriage
    target_train = find_train_tui
    return if target_train.nil?

    target_carriage = find_carriage_tui
    return if target_carriage.nil?

    target_train.add_carriage(target_carriage)
    puts 'Successfully set carriage!'
  end

  def remove_carriage
    target_train = find_train_tui
    return if target_train.nil?

    target_carriage = find_carriage_tui
    return if target_carriage.nil?

    target_train.remove_carriage(target_carriage)
    puts 'Seccessfully removed carriage!'
  end

  def traverse_forward
    target_train = find_train_tui
    return if target_train.nil?

    target_train.traverse_forward
  end

  def traverse_backward
    target_train = find_train_tui
    return if target_train.nil?

    target_train.traverse_backward
  end
end
