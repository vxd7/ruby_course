# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        raise TypeError, "#{name} is not a symbol" unless name.is_a?(Symbol)

        varname_sym = "@#{name}".to_sym
        histvar_method_sym = "#{name}_history".to_sym
        histvar_sym = "@#{histvar_method_sym}".to_sym

        # For saving history of the setter
        attr_reader histvar_method_sym

        # Getter
        define_method(name) { instance_variable_get(varname_sym) }

        # Setter
        define_method("#{name}=") do |val|
          # Initialize history_array
          history_array = instance_variable_get(histvar_sym)
          if history_array.nil?
            history_array = instance_variable_set(histvar_sym, [])
          end

          # Add val to array
          instance_variable_set(histvar_sym, history_array + [val])

          # And set new value
          instance_variable_set(varname_sym, val)
        end
      end
    end
  end
end
