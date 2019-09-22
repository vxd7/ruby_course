# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'validator'

class Carriage
  attr_reader :type, :id
  include ManufacturerCompany
  include Validator
  ID_PATTERN = /\w/.freeze

  def initialize(type, id)
    @type = type
    @id = id
    validate!
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  private

  def validate!
    raise "Id cannot be empty!" if id.empty?
    raise "Invalid id format" if id !~ ID_PATTERN
  end
end
