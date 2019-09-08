# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def add_carriage(carriage)
    return unless carirage.type == @type

    super
  end
end
