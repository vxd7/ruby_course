# frozen_string_literal: true

require_relative 'manufacturer_company'
# require_relative 'validator'
require_relative 'validation'

class Carriage
  attr_reader :type, :id
  attr_reader :available_space, :overall_space
  include ManufacturerCompany
  # include Validator
  include Validation

  ID_PATTERN = /\w/.freeze

  validate :id, :presence
  validate :id, :format, ID_PATTERN

  def initialize(type, id, overall_space)
    @type = type
    @id = id
    @overall_space = overall_space
    @available_space = overall_space
    validate!
  end

  def fill_space(fill_amount)
    raise 'Insufficient space' if (@available_space - fill_amount).negative?

    @available_space -= fill_amount
  end

  def filled_space
    @overall_space - @available_space
  end

  # private

  # def validate!
  #   raise 'Id cannot be empty!' if id.empty?
  #   raise 'Invalid id format' if id !~ ID_PATTERN
  # end
end
