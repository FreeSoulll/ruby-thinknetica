require_relative 'trains/train'
require_relative 'trains/passenger_train'
require_relative 'trains/cargo_train'
require_relative 'wagons/wagon'
require_relative 'wagons/passenger_wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'modules/railroad_default_text'
require_relative 'modules/railroad_controls'
require_relative 'modules/railroad_info'
require_relative 'modules/railroad_create'
require_relative 'route'
require_relative 'station'
require_relative 'custom_errors'

class RailRoad
  include RailRoadDefaultText
  include RailRoadControls
  include RailRoadCreate
  include RailRoadInfo

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
        when 1 then create_station
        when 2 then create_train
        when 3 then create_route
        when 4 then create_wagon
        when 0 then break
        else puts 'Введите команду из списка'
        end
      when 2
        puts OPERATION_TEXT
        create_operation = gets.chomp.to_i
        case create_operation
        when 1 then operation_with_route
        when 2 then operation_with_train
        when 3 then operation_with_wagon
        when 0 then break
        end
      when 3 then stations_list(stations)
      when 4 then info_from_stations
      when 5 then wagon_list_from_train
      when 0 then break
      else puts 'Введите команду из списка'
      end
      raise 'Осуществлен выход из команды' if first_step.zero?
    end
  end

  # загоняем все под private, потом у что пока не предполагается использование экземпляров класса
  private

  attr_writer :stations, :trains, :routes, :wagons

  def validate_array_of_entities!(entities, entity_name)
    raise("У вас нет #{entity_name}, сначала создайте хотя бы 1") unless entities.length.positive?
  end

  def operation_with_route
    validate_array_of_entities!(stations, 'станции')
    validate_array_of_entities!(routes, 'маршрутов')

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
  end

  def operation_with_train
    picked_train = pick_train
    puts OPERATION_WITH_TRAIN_TEXT
    create_operation = gets.chomp.to_i
    case create_operation
    when 1
      add_route_to_train(picked_train)
    when 2
      change_wagons(picked_train)
    when 3
      change_wagons(picked_train, :remove)
    when 4
      move_train(picked_train, :next)
    when 5
      move_train(picked_train)
    end
  end

  def operation_with_wagon
    validate_array_of_entities!(wagons, 'вагонов')

    puts OPERATION_WITH_WAGON_TEXT
    create_operation = gets.chomp.to_i

    case create_operation
    when 1
      items_list(wagons, 'вагонов')
      picked_wagon_index = gets.chomp.to_i
      picked_wagon = wagons[picked_wagon_index]
      take_place_in_wagon(picked_wagon)
    end
  end
end
