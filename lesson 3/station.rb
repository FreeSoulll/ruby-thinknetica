class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def sorted_trains(type)
    sorted_trains = []
    trains.each do |train|
      sorted_trains << train if train.type == type
    end
    sorted_trains
  end

  def go_train(train)
    trains.delete(train)
  end
end
