class Train
  attr_reader :number, :speed, :count_wagons, :type, :current_station

  def initialize(number, type, count_wagons)
    @number = number
    @type = type
    @count_wagons = count_wagons
    @speed = 0
  end

  # подкидываем в топ угля
  def gain_speed(speed)
    @speed += speed
  end

  # дергаем стоп-кран
  def stop
    @speed = 0
  end

  # добавляем вагон
  def change_count_wagons(change)
    return if @speed.positive?

    if change == 'add'
      @count_wagons += 1
    elsif change == 'remove'
      @count_wagons -= 1 if @count_wagons.positive?
    else
      puts 'Введите add для добавления или remove для удаления'
    end
  end

  # получаем маршрут
  def get_route(route)
    @route = route
    @current_station = route.list_stations[0]
  end

  # получаем следующую
  def next_station
    @route.list_stations[@route.list_stations.index(@current_station) + 1]
  end

  # получаем предыдущую станцию
  def previous_station
    @route.list_stations[@route.list_stations.index(@current_station) - 1]
  end

  # двигается на следующую станцию
  def move_next_station
    @current_station = @route.list_stations[@route.list_stations.index(@current_station) + 1]
  end
end
