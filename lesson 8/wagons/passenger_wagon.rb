require_relative '../modules/validatable'
require_relative '../custom_errors'

class PassengerWagon < Wagon
  attr_reader :free_places, :taked_places

  def initialize(number, free_space)
    super(number, free_space)
    validate!
    @free_places = free_space
    @taked_places = 0
  end

  def take_place
    raise NotEnoughPlace if free_space <= taked_places

    @taked_places += 1
    @free_places -= 1
  end

  def type
    :passenger
  end

  protected

  attr_writer :free_places, :taked_places

  def validate!
    raise ValidationError, 'Номер не может быть пустым' if number.to_s.empty?
    raise ValidationError, 'Размер/объем не может быть пустым' if free_space.to_s.empty?
  end
end
