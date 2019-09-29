# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, param=nil)
      raise TypeError, "#{name} argument should be a symbol" unless name.is_a?(Symbol)
      raise TypeError, "#{validation_type} argument should be a symbol" unless validation_type.is_a?(Symbol)

      case validation_type
      when 'presence'.to_sym
        define_method("#{name}_presence_validation") do
          self.class.presence_validation(instance_variable_get("@#{name}"))
        end

        private "#{name}_presence_validation".to_sym
      when 'type'.to_sym
        define_method("#{name}_type_validation") do
          self.class.type_validation(instance_variable_get("@#{name}"), param)
        end

        private "#{name}_type_validation".to_sym
      when 'format'.to_sym
        define_method("#{name}_format_validation") do
          self.class.format_validation(instance_variable_get("@#{name}"), param)
        end

        private "#{name}_format_validation".to_sym
      end
    end

    def presence_validation(var)
      return false if var.nil?

      if var.is_a?(String)
        return false if var.empty?
      end

      true
    end

    def format_validation(var, format)
      var =~ format
    end

    def type_validation(var, type)
      var.is_a?(type)
    end
  end

  module InstanceMethods
    def validate!
      private_methods.each do |method|
        next unless method =~ /.*(_presence|_type|_format)_validation/

        puts "validating #{method}"
        raise "ERROR #{method}" unless send(method)
      end
    end
  end
end
