class PassengerTrain < Train
  attr_reader :type

  def train_type
    @type = :passenger
  end

  def add_wagon(wagon)
    wagons << wagon if wagon.type == type
  end
end
