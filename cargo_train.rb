# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(id)
    super(id, 'cargo')
  end

  def add_carriage(carriage)
    return unless carriage.type == 'cargo'

    super(carriage)
  end
end
