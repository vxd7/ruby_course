# frozen_string_literal: true

require_relative 'manufacturer_company'

class Carriage
  attr_reader :type, :id
  include ManufacturerCompany

  def initialize(type, id)
    @type = type
    @id = id
  end
end
