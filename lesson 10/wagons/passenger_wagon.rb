# frozen_string_literal: true

require_relative '../modules/validatable'
require_relative '../modules/validation'
require_relative '../custom_errors'
require_relative '../modules/accessors'

class PassengerWagon < Wagon
  include Validation
  extend Accessors

  attr_reader :free_places, :taked_places

  validate :free_places, :presence
  validate :number, :presence

  def initialize(number, free_places)
    super(number)
    @free_places = free_places
    validate!
    @taked_places = 0
  end

  def take_place
    raise NotEnoughPlace if free_places.zero?

    self.taked_places += 1
    self.free_places -= 1
  end

  def type
    :passenger
  end

  protected

  attr_writer :free_places, :taked_places
end
