# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def add_carriage(carriage)
    return unless carriage.type == @type

    super
  end
end
