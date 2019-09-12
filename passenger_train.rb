# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(id)
    super(id, 'passenger')
  end

  def add_carriage(carriage)
    return unless carriage.type == 'passenger'

    super(carriage)
  end
end
