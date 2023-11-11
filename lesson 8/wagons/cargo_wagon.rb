class CargoWagon < Wagon
  attr_reader :free_volue, :taked_volue

  def initialize(number, free_space)
    super(number, free_space)
    @free_volue = free_space
    @taked_volue = 0
  end

  def take_place(added_volue)
    raise NotEnoughVolue if added_volue > free_volue

    @taked_volue += added_volue
    @free_volue -= added_volue
  end

  def type
    :cargo
  end

  protected

  attr_writer :free_volue, :taked_volue
end
