class CargoWagon < Wagon
  attr_reader :type

  def initialize
    super
    @type = :cargo
  end
end
