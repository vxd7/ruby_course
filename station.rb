class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select do |train|
      train.type == type
    end
  end

  def send_train(train)
    if @trains.include? train
      @trains.delete train
    end
  end
end
