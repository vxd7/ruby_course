# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'validator'

class Carriage
  attr_reader :type, :id
  attr_reader :available_space, :overall_space
  include ManufacturerCompany
  include Validator
  ID_PATTERN = /\w/.freeze

  def initialize(type, id, overall_space)
    @type = type
    @id = id
    @overall_space = overall_space
    @avaliable_space = overall_space
    validate!
  end

  def fill_space(fill_amount)
    raise 'Insufficient space' if (@avaliable_space - fill_amount).negative?

    @avaliable_space -= fill_amount
  end

  def filled_space
    @overall_space - @avaliable_space
  end

  private

  def validate!
    raise 'Id cannot be empty!' if id.empty?
    raise 'Invalid id format' if id !~ ID_PATTERN
  end
end
