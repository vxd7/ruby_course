# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(id, overall_volume)

    super('cargo', id, overall_volume)
  end
end
