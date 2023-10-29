class PassengerWagon < Wagon
  attr_reader :type

  def initialize
    super
    @type = :passenger
  end
end
