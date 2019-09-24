# frozen_string_literal: true

class TrainManagement
  attr_reader :trains, :carriages
  MAX_USER_ATTEMPTS = 3

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
    @railroad_manager.route_manager.routes.find { |route| route.name == route_name }
  end

  def find_carriage_tui
    puts 'Pls input carriage id'
    carriage_id = gets.chomp
    @carriages.find { |carriage| carriage.id == carriage_id }
  end

  def new_train!(train_id, train_type)
    case train_type
    when 'passenger'
      new_train = PassengerTrain.new(train_id)
    when 'cargo'
      new_train = CargoTrain.new(train_id)
    else
      puts 'Incorrect train type! Cannot proceed'
      return
    end

    @trains << new_train
  end

  def new_carriage!(carriage_id, carriage_type, carriage_volume)
    case carriage_type
    when 'passenger'
      new_carriage = PassengerCarriage.new(carriage_id, carriage_volume)
    when 'cargo'
      new_carriage = CargoCarriage.new(carriage_id, carriage_volume)
    else
      puts 'Invalid carriage type! Cannot proceed'
      return
    end

    @carriages << new_carriage
  end

  def set_route!(target_train, target_route)
    if target_train.nil?
      puts 'Invalid train! Cannot proceed'
      return
    end

    target_train.set_route(target_route)
  end

  def alter_carriages!(target_train, target_carriage, action)
    if target_train.nil?
      puts 'Invalid train! Cannot proceed'
      return
    end

    case action
    when 'add'
      target_train.add_carriage(target_carriage)
    when 'remove'
      target_train.remove_carriage(target_carriage)
    else
      puts 'Invalid action! Cannot proceed'
      return
    end
  end

  def show_carriage_info(carr)
    puts "Carriage: #{carr.id}:"
    puts " > type: #{carr.type}"

    case carr.type
    when 'passenger'
      puts " > number of seats: #{carr.overall_seats}"
      puts " > number of taken seats: #{carr.taken_seats}"
      puts " > number of free seats: #{carr.avaliable_seats}"
    when 'cargo'
      puts " > overall volume: #{carr.overall_volume}"
      puts " > filled volume: #{carr.filled_volume}"
      puts " > avaliable volume: #{carr.avaliable_volume}"
    end
  end

  public

  def new_train
    attempt = 0
    begin
      attempt += 1

      puts 'Pls input new train id'
      train_id = gets.chomp

      puts 'Pls input train type (passenger, cargo)'
      train_type = gets.chomp

      new_train!(train_id, train_type)
    rescue StandardError => e
      puts "There was an error: #{e.message}"

      if attempt < MAX_USER_ATTEMPTS
        puts 'Please try again'
        retry
      else
        puts 'Max number of attempts reached!'
        return
      end
    end

    puts "Created train #{train_id} with type: #{train_type}"
  end

  def list_trains
    return if @trains.empty?

    puts 'Avaliable trains:'
    @trains.each do |train|
      puts "Id: #{train.id}; Type: #{train.type}; "\
           "# of carriages: #{train.number_carriages}"
    end
  end

  def list_carriages
    return if @carriages.empty?

    puts 'Avaliable carriages:'
    @carriages.each { |carriage| puts "ID: #{carriage.id}; Type: #{carriage.type}" }
  end

  def list_carriages_in_train
    list_trains

    train = find_train_tui
    train.each_carriage { |carr| show_carriage_info(carr) }
  end

  def new_carriage
    attempt = 0
    begin
      attempt += 1

      puts 'Pls input new carriage id:'
      carriage_id = gets.chomp

      puts "Pls input desired type for carriage #{carriage_id}"
      carriage_type = gets.chomp

      puts 'Pls input carriage volume/number of seats for '\
           "carriage #{carriage_id}"
      carriage_volume = gets.chomp.to_i

      new_carriage!(carriage_id, carriage_type, carriage_volume)
    rescue StandardError => e
      puts "There was an error: #{e.message}"

      puts 'Please try again' if attempt < MAX_USER_ATTEMPTS
      retry if attempt < MAX_USER_ATTEMPTS
    end

    puts "Created carriage #{carriage_id}!"
  end

  def set_route
    # Show all the trains and routes to the user
    list_trains
    @railroad_manager.route_manager.list_routes

    attempt = 0
    begin
      attempt += 1
      target_train = find_train_tui
      target_route = find_route_tui

      set_route!(target_train, target_route)
    rescue StandardError => e
      puts "There was an error: #{e.message}"

      puts 'Please try again' if attempt < MAX_USER_ATTEMPTS
      retry if attempt < MAX_USER_ATTEMPTS
    end

    puts "Successfully set route #{target_route.name} for"\
         "the train #{target_train.id}!"
  end

  def add_carriage
    list_trains
    list_carriages

    attempt = 0
    begin
      attempt += 1
      target_train = find_train_tui
      target_carriage = find_carriage_tui

      alter_carriages!(target_train, target_carriage, 'add')
    rescue StandardError => e
      puts "There was an error: #{e.message}"

      puts 'Please try again' if attempt < MAX_USER_ATTEMPTS
      retry if attempt < MAX_USER_ATTEMPTS
    end

    puts 'Successfully set carriage!'
  end

  def remove_carriage
    list_trains
    list_carriages

    target_train = find_train_tui
    if target_train.nil?
      puts 'Invalid train! Cannot proceed'
      return
    end
    target_carriage = find_carriage_tui

    alter_carriages!(target_train, target_carriage, 'remove')

    puts 'Seccessfully removed carriage!'
  end

  def traverse_forward
    list_trains

    target_train = find_train_tui
    if target_train.nil?
      puts 'Invalid train! Cannot proceed'
      return
    end

    target_train.traverse_next_station

  rescue StandardError => e
    puts 'There was an error while traversing the train forward'
    puts "The error was: #{e.message}"
  end

  def traverse_backward
    list_trains

    target_train = find_train_tui
    if target_train.nil?
      puts 'Invalid train! Cannot proceed'
      return
    end

    target_train.traverse_prev_station
  rescue StandardError => e
    puts 'There was an error while traversing the train forward'
    puts "The error was: #{e.message}"
  end
end
