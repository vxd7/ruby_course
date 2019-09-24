# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :avaliable_volume

  def initialize(id, overall_volume)
    @overall_volume = overall_volume
    @avaliable_volume = overall_volume

    super('cargo', id)
  end

  def fill_volume(fill_value)
    if (@avaliable_volume - fill_value).negative?
      raise "Cannot fill #{fill_volume} volume to the "\
            'carriage: insufficient space!'
    end

    @avaliable_volume -= fill_value
  end

  def filled_volume
    @overall_volume - @avaliable_volume
  end
end
