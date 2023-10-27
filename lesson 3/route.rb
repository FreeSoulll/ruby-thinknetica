class Route
  attr_reader :list_stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_stations = [@first_station, @last_station]
  end

  # добавляем промежуточную станцию в список
  def add_station(station)
    @list_stations.insert(-2, station)
  end

  # удаляем промежуточную станцию из списка
  def remove_station(station)
    @list_stations.delete(station)
  end
end
