class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def trains_by_type(type)
  end

  def send_train
    @trains.pop
  end
end

class Route
end

class Train
end
