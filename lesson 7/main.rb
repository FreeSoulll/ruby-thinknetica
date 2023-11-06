require_relative 'trains/train'
require_relative 'trains/passenger_train'
require_relative 'trains/cargo_train'
require_relative 'wagons/wagon'
require_relative 'wagons/passenger_wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'route'
require_relative 'station'

class RailRoad
  FIRST_ITERATION_TEXT = [
    'Введите 1, если хотите создать станцию, поезд, вагон или маршрут',
    'Введите 2, если хотите произвести операции с созданными объектами',
    'Введите 3, если хотите вывести текущие данные об объектах',
    'Введите 0, если хотите закончить программу'
  ].freeze

  CREATE_TEXT = [
    'Введите 1, если хотите создать станцию',
    'Введите 2, если хотите создать поезд',
    'Введите 3, если хотите создать маршрут',
    'Введите 4, если хотите создать вагон',
    'Введите 0, или стоп если хотите закончить программу'
  ].freeze

  OPERATION_TEXT = [
    'Введите 1, если провести операции с маршрутом',
    'Введите 2, если хотите произвести операцию с поездом',
    'Введите 0, если хотите закончить программу'
  ].freeze

  OPERATION_WITH_STATION_TEXT = [
    'Введите 1, если хотите добавить станцию к маршруту',
    'Введите 2, если хотите удалить станцию у маршрута',
    'Введите 0, если хотите выйти'
  ].freeze

  OPERATION_WITH_TRAIN_TEXT = [
    'Введите 1, Если хотите назначить маршрут поезду',
    'Введите 2, если хотите добавить вагоны к поезду',
    'Введите 3, если хотите отцепить вагоны от поезда',
    'Введите 4, если хотите переместить поезд по маршруту вперед',
    'Введите 5, если хотите переместить поезд по маршруту назад',
    'Введите 0, если хотите закончить программу'
  ].freeze

  attr_reader :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def seed
    stations << Station.new('Москва')
    stations << Station.new('Петушки')
    trains << PassengerTrain.new('qqq-56')
    trains << CargoTrain.new('asd-12')
    routes << Route.new(stations[0], stations[1])
    wagons << PassengerWagon.new()
    wagons << CargoWagon.new()
  end

  def menu
    loop do
      puts FIRST_ITERATION_TEXT

      first_step = gets.chomp.to_i
      case first_step
      when 1
        puts CREATE_TEXT
        create_object = gets.chomp.to_i
        case create_object
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          create_wagon
        when 0
          break
        else
          'Введите команду из списка'
        end
      when 2
        puts OPERATION_TEXT
        create_operation = gets.chomp.to_i
        case create_operation
        when 1
          break if validate_routes || validate_stations

          # выводим список маршрутов
          routes_list
          picked_route = gets.chomp.to_i

          puts OPERATION_WITH_STATION_TEXT
          route_operation = gets.chomp.to_i
          case route_operation
          when 1
            add_station(picked_route)
          when 2
            remove_station(picked_route)
          end
        when 2
          break if validate_trains

          picked_train = trains_list
          puts OPERATION_WITH_TRAIN_TEXT
          create_operation = gets.chomp.to_i

          case create_operation
          when 1
            break if validate_routes

            # выводим список маршрутов
            routes_list
            picked_route = gets.chomp.to_i
            picked_train.add_route(routes[picked_route])
          when 2
            break if validate_wagons

            change_wagons(picked_train)
          when 3
            break if wagons_from_train(picked_train)

            change_wagons(picked_train, :remove)
          when 4
            picked_train.move_next_station
          when 5
            picked_train.move_previous_station
          when 0
            break
          end
        when 0
          break
        end
      when 3
        stations_list(stations)
      when 0
        break
      else
        'Введите команду из списка'
      end
      break if first_step.zero?
    end
  end

  # загоняем все под private, потом у что пока не предполагается использование экземпляров класса
  private

  attr_writer :stations, :trains, :routes, :wagons

  def validate_routes
    puts 'У вас нет маршрутов, сначала создайте хотя бы 1' unless routes.length > 0
  end

  def validate_trains
    puts 'У вас нет поездов, сначала создайте хотя бы 1' unless trains.length > 0
  end

  def validate_stations
    puts 'У вас нет станции, сначала создайте хотя бы 1' unless stations.length > 0
  end

  def validate_remove_stations(stations)
    puts 'У вас нет станции для удаления, сначала создайте хотя бы 1' unless stations.length > 0
  end

  def validate_wagons
    puts 'У вас нет вагонов, сначала создайте хотя бы 1' unless wagons.length > 0
  end

  def wagons_from_train(train)
    puts 'У поезда нет вагонов, сначала добавьте хотя бы 1' unless train.wagons.length > 0
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    stations << Station.new(station_name) if station_name
  end

  def create_train
    puts 'Введите номер поезда поезда'
    train_number = gets.chomp
    puts 'Введите 1 если поезд пассажирский или любой другой символ если поезд грузовой'
    train_type = gets.chomp.to_i

    if train_type == 1
      train = PassengerTrain.new(train_number)
    else
      train = CargoTrain.new(train_number)
    end

    trains << train
    puts "Создан поезд  - #{train}"
  # runtime потому что там всегда один номер только проверяется, а в нем этот тип только
  rescue RuntimeError => e
    puts e.message
    retry if train.nil? && !train&.valid?
  end

  def create_route
    puts 'Введите название первой станции'
    first_name = gets.chomp
    first_station = Station.new(first_name) if first_name
    stations << first_station

    puts 'Введите название второй станции'
    second_name = gets.chomp
    second_station = Station.new(second_name) if second_name
    stations << second_station

    routes << Route.new(first_station, second_station)
  end

  def create_wagon
    puts 'Укажите 1 если хотите создать пассажирский или 2 если хотите создать грузовой вагон'
    type_wagon = gets.chomp.to_i
    return wagons << PassengerWagon.new if type_wagon == 1

    wagons << CargoWagon.new
  end

  def add_station(picked_route)
    puts 'Вот список  Станций, выберите индекс той, которую хотите добавить'
    uniq_list = stations.difference(routes[picked_route].list_stations)
    puts uniq_list
    stations_list(uniq_list)
    picked_station = gets.chomp.to_i
    routes[picked_route].add_station(uniq_list[picked_station])
  end

  def remove_station(picked_route)
    stations_route_list = routes[picked_route]
                          .list_stations
                          .slice(1, routes[picked_route].list_stations.length - 2)
    puts stations_route_list
    return if validate_remove_stations(stations_route_list)

    puts 'Вот список  Станций, выберите индекс той, которую хотите удалить'
    stations_list(stations_route_list)
    picked_station = gets.chomp.to_i
    routes[picked_route].remove_station(stations[picked_station + 1])
  end

  def change_wagons(picked_train, arg = :add)
    puts 'Вот список вагонов, введите индекс нужного'

    if arg == :remove
      picked_train.wagons.each_with_index { |wagon, index| puts "#{index}) - #{wagon}" }
      picked_wagon = gets.chomp.to_i
      picked_train.remove_wagon(wagons[picked_wagon]) 
    else
      wagons.each_with_index { |wagon, index| puts "#{index}) - #{wagon}" }
      picked_wagon = gets.chomp.to_i
      picked_train.add_wagon(wagons[picked_wagon])
    end
  end

  def trains_list
    puts 'Вот список поездов, введите индекс нужного'
    trains.each_with_index { |train, index| puts "#{index}) - #{train}" }
    picked_train_index = gets.chomp.to_i
    trains[picked_train_index]
  end

  def routes_list
    puts 'Вот список маршрутов, введите индекс нужного'
    routes.each_with_index { |route, index| puts "#{index}) - #{route}" }
  end

  def stations_list(sorted_stations)
    sorted_stations.each_with_index do |station, index|
      puts "#{index}) Название станции - #{station.name}, поезда на этой станции - #{station.trains}"
    end
  end
end
