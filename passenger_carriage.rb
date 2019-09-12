# frozen_string_literal: true
require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(id)
    super('passenger', id)
  end
end
