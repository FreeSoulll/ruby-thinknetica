# frozen_string_literal: true

require_relative '../modules/validation'
require_relative '../custom_errors'
require_relative '../modules/accessors'

class CargoWagon < Wagon
  include Validation
  extend Accessors

  attr_reader :free_volue, :taked_volue

  validate :free_volue, :presence
  validate :number, :presence

  def initialize(number, free_volue)
    super(number)
    @free_volue = free_volue
    validate!
    @taked_volue = 0
  end

  def take_volue(added_volue)
    raise NotEnoughVolue if added_volue > free_volue

    self.taked_volue += added_volue
    self.free_volue -= added_volue
  end

  def type
    :cargo
  end

  protected

  attr_writer :free_volue, :taked_volue
end
