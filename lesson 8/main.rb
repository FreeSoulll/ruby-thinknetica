require_relative 'trains/train'
require_relative 'trains/passenger_train'
require_relative 'trains/cargo_train'
require_relative 'wagons/wagon'
require_relative 'wagons/passenger_wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'custom_errors'

class RailRoad
  FIRST_ITERATION_TEXT = [
    'Введите 1, если хотите создать станцию, поезд, вагон или маршрут',
    'Введите 2, если хотите произвести операции с созданными объектами',
    'Введите 3, если хотите вывести текущие данные об объектах',
    'Введите 4, если хотите вывести полную информацию по станциям',
    'Введите 5, если хотите вывести список вагонов у поезда',
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
    'Введите 3, если хотите произвести операцию с вагоном',
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

  OPERATION_WITH_WAGON_TEXT = [
    'Введите 1, Если хотите изменить количество свободны мест/объема в вагоне',
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
    train1 = PassengerTrain.new('122-12')
    station1 = Station.new('Москва')
    wagon1 = PassengerWagon.new(20, 12)
    train1.add_wagon(wagon1)
    station1.add_train(train1)
    stations << station1
    stations << Station.new('Петушки')
    trains << train1
    trains << CargoTrain.new('153-22')
    routes << Route.new(stations[0], stations[1])
    wagons << wagon1
    wagons << CargoWagon.new(200, 1)
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
          validate_array_of_entities!(stations, 'станции')
          validate_array_of_entities!(routes, 'маршрутов')

          # выводим список маршрутов
          items_list(routes, 'маршрутов')
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
          validate_array_of_entities!(trains, 'поездов')
          items_list(routes, 'маршрутов')

          picked_train_index = gets.chomp.to_i
          picked_train = trains[picked_train_index]
          puts OPERATION_WITH_TRAIN_TEXT
          create_operation = gets.chomp.to_i

          case create_operation
          when 1
            validate_array_of_entities!(routes, 'маршрутов')

            # выводим список маршрутов
            items_list(routes, 'маршрутов')
            picked_route = gets.chomp.to_i
            picked_train.add_route(routes[picked_route])
          when 2
            validate_array_of_entities!(wagons, 'вагонов')

            change_wagons(picked_train)
          when 3
            validate_array_of_entities!(train.wagons, 'у поезда  вагонов')

            change_wagons(picked_train, :remove)
          when 4
            begin
              picked_train.move_next_station
            rescue TrainException => e
              puts e.message
            end
          when 5
            begin
              picked_train.move_previous_station
            rescue TrainException => e
              puts e.message
            end
          when 0
            break
          end
        when 3
          # нужно добавить валидацию
          # вагон
          validate_array_of_entities!(wagons, 'вагонов')

          puts OPERATION_WITH_WAGON_TEXT
          create_operation = gets.chomp.to_i

          case create_operation
          when 1
            items_list(wagons, 'вагонов')
            picked_wagon_index = gets.chomp.to_i
            picked_wagon = wagons[picked_wagon_index]

            take_place_in_wagon(picked_wagon)
          when 0
            break
          end
        when 0
          break
        end
      when 3
        stations_list(stations)
      when 4
        stations.each do |station|
          puts "Информация по станици #{station.name}"
          station.trains_info do |train|
            puts "Номер поезда - #{train.number}, тип - #{train.type}, количество вагонов - #{train.wagons.length}"
            train_wagons_info(train, 'свободное место')
          end
        end
      when 5
        validate_array_of_entities!(trains, 'поездов')
        items_list(trains, 'поездов')
        picked_train_index = gets.chomp.to_i
        picked_train = trains[picked_train_index]
        train_wagons_info(picked_train, 'свободных мест')
      when 0
        break
      else
        'Введите команду из списка'
      end
      raise 'Осуществлен выход из команды' if first_step.zero?
    end
  end

  # загоняем все под private, потом у что пока не предполагается использование экземпляров класса
  private

  attr_writer :stations, :trains, :routes, :wagons

  def validate_array_of_entities!(entities, entity_name)
    raise("У вас нет #{entity_name}, сначала создайте хотя бы 1") unless entities.length > 0
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    stations << Station.new(station_name) if station_name

  rescue ValidationError => e
    puts e.message
    retry
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
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    puts 'Введите название первой станции'
    first_name = gets.chomp
    first_station = Station.new(first_name)
    stations << first_station

    puts 'Введите название второй станции'
    second_name = gets.chomp
    second_station = Station.new(second_name)
    stations << second_station

    routes << Route.new(first_station, second_station)
  rescue ValidationError => e
    puts e.message
    retry
  end

  def create_wagon
    puts 'Укажите 1 если хотите создать пассажирский или любой другой символ, если хотите создать грузовой вагон'
    type_wagon = gets.chomp.to_i
    puts 'Укажите номер вагона'
    wagon_number = gets.chomp.to_i

    type_wagon == 1 ? puts('Укажите кол-во мест') : puts('Укажите кол-во объема')
    wagon_size = gets.chomp.to_i

    return wagons << PassengerWagon.new(wagon_number, wagon_size) if type_wagon == 1

    wagons << CargoWagon.new(wagon_number, wagon_size)
  rescue ValidationError => e
    puts e.message
    retry
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
    validate_array_of_entities!(stations, 'станции для удаления')

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
  rescue TrainException => e
    puts e.message
  end

  def items_list(entity, entity_name)
    puts "Вот список #{entity_name}, введите индекс нужного"
    entity.each_with_index { |item, index| puts "#{index}) - #{item}" }
  end

  def stations_list(sorted_stations)
    sorted_stations.each_with_index do |station, index|
      puts "#{index}) Название станции - #{station.name}, поезда на этой станции - #{station.trains}"
    end
  end

  def take_place_in_wagon(wagon)
    if wagon.type == :passenger
      wagon.take_place
    else
      puts "Текущий свободный объем - #{wagon.free_volue}. Укажите какой объем нужно занять"
      added_volue = gets.chomp.to_i
      wagon.take_volue(added_volue)
    end
  rescue WagonException => e
    puts e.message
    retry
  end

  def train_wagons_info(train, text)
    train.wagons_info do |wagon|
      wagon_free_space = wagon.type == :passenger ? wagon.free_places : wagon.free_volue
      puts "Номер вагона - #{wagon.number}, тип вагона - #{wagon.type}, #{text} - #{wagon_free_space}"
    end
  end
end
