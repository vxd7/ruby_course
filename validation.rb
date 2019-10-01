# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations_array

    def validate(name, validation_type, param = nil)
      raise TypeError, "#{name} argument should be a symbol" unless name.is_a?(Symbol)
      raise TypeError, "#{validation_type} argument should be a symbol" unless validation_type.is_a?(Symbol)

      @validations_array ||= []

      current_validation = [name, validation_type, param]

      @validations_array << current_validation
    end
  end

  module InstanceMethods
    def validate_presence(var, _param = nil)
      raise ArgumentError, "#{var} is not present" if var.nil?

      if var.is_a?(String)
        raise ArgumentError, "#{var} is empty" if var.empty?
      end

      true
    end

    def validate_format(var, format)
      unless var =~ format
        raise ArgumentError, "#{var} does not conform to the format #{format}"
      end

      true
    end

    def validate_type(var, type)
      raise ArgumentError, "#{var} is not of type #{type}" unless var.is_a?(type)

      true
    end

    def validate!
      return if self.class.validations_array.nil?

      self.class.validations_array.each do |name, val_type, param|
        send("validate_#{val_type}", instance_variable_get("@#{name}"), param)
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end
  end
end
