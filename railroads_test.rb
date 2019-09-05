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
puts train.current_station.name

train.traverse_next_station
puts train.current_station.name

train.traverse_next_station
puts train.current_station.name
 
train.traverse_next_station
puts train.current_station.name

train.traverse_next_station
puts train.current_station.name

# We are currently on station5
puts "There are passenger trains on station1" if not station1.trains_by_type("passenger").empty?
puts "There are cargo trains station 1" if not station1.trains_by_type("cargo").empty?

puts "There are passenger trains on station5" if not station5.trains_by_type("passenger").empty?
puts "There are cargo trains station 5" if not station5.trains_by_type("cargo").empty?

# Test remove_intermediate_stations
# This should not remove station1
puts "After remove_intermediate_station(station1)"
route.remove_intermediate_station(station1)
route.list_all_stations

# This should not remove station5
puts "After remove_intermediate_station(station5)"
route.remove_intermediate_station(station5)
route.list_all_stations

route.remove_intermediate_station(station3)
route.remove_intermediate_station(station2)
route.remove_intermediate_station(station4)

# There should be now only two stations left -- first and last
puts "After removing every intermediate station"
route.list_all_stations
