class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  # принимаем поезд
  def add_train(train)
    @trains << train
  end

  # получаем список поездов по типу
  def get_sorted_trains(type)
    @trains.each do |train|
      puts train if train.type == type
    end
  end

  # отправляем поезд
  def go_train(train)
    @trains.delete(train)
  end
end
