class Train
  attr_reader :number, :type, :route
  attr_accessor :speed, :count_wagons, :current_station

  def initialize(number, type, count_wagons)
    @number = number
    @type = type
    @count_wagons = count_wagons
    @speed = 0
  end

  def gain_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end

  def change_count_wagons(change)
    return if speed.positive?

    if change == 'add'
      self.count_wagons += 1
    elsif change == 'remove' && self.count_wagons.positive?
      self.count_wagons -= 1
    else
      puts 'Введите add для добавления или remove для удаления'
    end
  end

  def add_route(route)
    @route = route
    self.current_station = route.list_stations[0]
    current_station.add_train(self)
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
end
