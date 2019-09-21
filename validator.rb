module Validator
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
