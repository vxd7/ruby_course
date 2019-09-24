# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :avaliable_seats

  def initialize(id, overall_seats)
    @overall_seats = overall_seats
    @avaliable_seats = overall_seats

    super('passenger', id)
  end

  def take_seat
    raise 'No seats avaliable' if @avaliable_seats.zero?

    @avaliable_seats -= 1
  end

  def taken_seats
    @overall_seats - @avaliable_seats
  end
end
