module RailRoadCreate
  private

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

    train = CargoTrain.new(train_number)
    train = PassengerTrain.new(train_number) if train_type == 1

    trains << train
    puts "Создан поезд  - #{train}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    create_station
    first_station = stations.last
    create_station
    second_station = stations.last

    routes << Route.new(first_station, second_station)
  end

  def create_wagon
    type_wagon, wagon_number, wagon_size = info_for_create_wagon
    return wagons << PassengerWagon.new(wagon_number, wagon_size) if type_wagon == 1

    wagons << CargoWagon.new(wagon_number, wagon_size)
  end
end
