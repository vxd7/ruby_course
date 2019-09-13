# frozen_string_literal: true

class Carriage
  attr_reader :type, :id

  def initialize(type, id)
    @type = type
    @id = id
  end
end
