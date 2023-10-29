class Train
  attr_reader :number, :type, :route
  attr_accessor :speed, :current_station, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
  end

  def add_route(route)
    @route = route
    self.current_station = route.list_stations[0]
    current_station.add_train(self)
  end

  def remove_wagon(wagon)
    wagons.delete(wagon) if wagons.include?(wagon)
  end

  def next_station
    new_station_index = route.list_stations.index(current_station) + 1
    return unless new_station_index <= route.list_stations.length - 1

    route.list_stations[new_station_index]
  end

  def previous_station
    new_station_index = route.list_stations.index(current_station) - 1
    return unless new_station_index > -1

    route.list_stations[new_station_index]
  end

  def move_next_station
    return unless next_station

    current_station.go_train(self)
    self.current_station = next_station
    current_station.add_train(self)
  end

  def move_previous_station
    return unless previous_station

    current_station.go_train(self)
    self.current_station = previous_station
    current_station.add_train(self)
  end

  # Даныне методы скорее всего будут юзаться внутри класса, так что вынес их сюда
  protected

  def gain_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end
end
