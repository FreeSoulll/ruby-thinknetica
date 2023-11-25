# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(name, type, *args)
      validations << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |item|
        curent_type = item[:type].to_sym
        curent_attr = "@#{item[:name]}".to_sym
        attr_value = instance_variable_get(curent_attr)

        case curent_type
        when :presence
          send(:presence_validate, attr_value)
        when :format
          validate_format = item[:args][0]
          puts attr_value !~ validate_format
          send(:format_validate, attr_value, validate_format)
        when :type
          validate_type = item[:args][0]
          send(:type_validate, attr_value, validate_type)
        else
          puts 'Enter valid type'
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end

  private

  def presence_validate(value)
    puts "create train #{value}"
    raise PresenceValidate if value.nil? || value.to_s.empty?
  end

  def format_validate(value, value_format)
    puts value_format
    puts value !~ value_format
    raise FormatValidate if value.nil? || value !~ value_format
  end

  def type_validate(value, type)
    raise TypeValidate unless value.instance_of?(type)
  end
end

class Test
  include Validation

  validate :name, :presence
  validate :number, :format, '[A-Z]{0,3}'
  validate :name, :type, String
  def initialize
    @name = 'aads'
    @number = 'AZ'
    validate!
  end
end
