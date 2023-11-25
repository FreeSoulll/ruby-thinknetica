# frozen_string_literal: true

require_relative './modules/instance_counter'
require_relative './modules/validatable'
require_relative './custom_errors'
require_relative './modules/validation'
require_relative './modules/accessors'

class Station
  include InstanceCounter
  include Validatable
  include Validation
  extend Accessors

  attr_reader :trains, :name

  @@all_staions = []

  def self.all
    @@all_staions
  end

  validate :name, :presence

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_staions << self
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def sorted_trains(type)
    trains.select { |train| train.type == type }
  end

  def go_train(train)
    trains.delete(train)
  end

  def trains_info(&block)
    trains.each { |train| block.call(train) }
  end
end
