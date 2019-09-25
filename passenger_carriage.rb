# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage

  def initialize(id, overall_seats)
    super('passenger', id, overall_seats)
  end

  def fill_space
    super(1)
  end
end
