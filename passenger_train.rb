# frozen_string_literal: true

class PassengerTrain < Train
  def add_carriage(carriage)
    return unless carriage.type == @type

    super
  end
end
