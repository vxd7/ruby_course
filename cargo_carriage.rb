# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(id)
    super('cargo', id)
  end
end
