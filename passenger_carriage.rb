# frozen_string_literal: true
require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize
    super('Passenger')
  end
end
