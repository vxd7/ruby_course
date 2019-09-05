require_relative 'station'
require_relative 'route'
require_relative 'train'

station1 = Station.new("station1")
station2 = Station.new("station2")
station3 = Station.new("station3")
station4 = Station.new("station4")
station5 = Station.new("station5")

# Make route st1 -> st2 -> st3 -> st4 -> st5
route = Route.new(station1, station5)
route.add_intermediate_station(station2)
route.add_intermediate_station(station3)
route.add_intermediate_station(station4)

# Make train
train = Train.new(123, "passenger", 10)
train.set_route(route)
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name
 
train.traverse_next_station
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name

train.traverse_next_station
puts train.get_cur_station.name

# We are currently on station1
puts "There are passenger trains on station1" if not station1.trains_by_type("passenger").empty?
puts "There are cargo trains station 1" if not station1.trains_by_type("cargo").empty?

puts "There are passenger trains on station2" if not station2.trains_by_type("passenger").empty?
puts "There are cargo trains station 2" if not station2.trains_by_type("cargo").empty?
