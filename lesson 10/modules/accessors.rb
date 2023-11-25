# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |name|
      curent_attr = "@#{name}".to_sym
      define_method(name) { instance_variable_get(curent_attr) }

      define_method("#{name}_history") do
        instance_variable_get(curent_attr)
      end

      define_method("#{name}=".to_sym) do |value|
        if instance_variable_defined?(curent_attr)
          current_value = instance_variable_get(curent_attr)
          current_value << value
          instance_variable_set(curent_attr, current_value)
        else
          instance_variable_set(curent_attr, [value])
        end
      end
    end
  end

  def strong_attr_accessor(name, attr_class)
    curent_attr = "@#{name}".to_sym
    define_method(name) { instance_variable_get(curent_attr) }

    define_method("#{name}=") do |value|
      raise('the types dont match') unless value.instance_of?(attr_class)

      instance_variable_set(curent_attr, value)
    end
  end
end
