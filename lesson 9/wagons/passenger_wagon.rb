# frozen_string_literal: true

require_relative '../modules/validatable'
require_relative '../custom_errors'

class PassengerWagon < Wagon
  attr_reader :free_places, :taked_places

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

  def validate!
    raise ValidationError, 'Номер не может быть пустым' if number.to_s.empty?
    raise ValidationError, 'Количество мест не может быть пустым' if free_places.to_s.empty?
  end
end
