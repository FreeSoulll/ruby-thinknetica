class CargoWagon < Wagon
  attr_reader :free_volue, :taked_volue

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

  def validate!
    raise ValidationError, 'Номер не может быть пустым' if number.to_s.empty?
    raise ValidationError, 'Количество мест не может быть пустым' if free_volue.to_s.empty?
  end
end
