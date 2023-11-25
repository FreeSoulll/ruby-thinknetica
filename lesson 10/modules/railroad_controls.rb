# frozen_string_literal: true

module RailRoadControls
  private

  def add_station(picked_route)
    puts 'Вот список  Станций, выберите индекс той, которую хотите добавить'
    uniq_list = stations.difference(routes[picked_route].list_stations)
    puts uniq_list
    stations_list(uniq_list)
    picked_station = gets.chomp.to_i
    routes[picked_route].add_station(uniq_list[picked_station])
  end

  def added_list_stations(picked_route)
    routes[picked_route].list_stations.slice(1, routes[picked_route].list_stations.length - 2)
  end

  def remove_station(picked_route)
    stations_route_list = added_list_stations
    puts stations_route_list
    validate_array_of_entities!(stations, 'станции для удаления')

    puts 'Вот список  Станций, выберите индекс той, которую хотите удалить'
    stations_list(stations_route_list)
    picked_station = gets.chomp.to_i
    routes[picked_route].remove_station(stations[picked_station + 1])
  end

  def remove_wagon(train)
    train.wagons.each_with_index { |wagon, index| puts "#{index}) - #{wagon}" }
    picked_wagon = gets.chomp.to_i
    train.remove_wagon(wagons[picked_wagon])
  end

  def add_wagon(train)
    wagons.each_with_index { |wagon, index| puts "#{index}) - #{wagon}" }
    picked_wagon = gets.chomp.to_i
    train.add_wagon(wagons[picked_wagon])
  end

  def change_wagons(picked_train, arg = :add)
    puts 'Вот список вагонов, введите индекс нужного'

    if arg == :remove
      validate_array_of_entities!(wagons, 'вагонов')
      remove_wagon(picked_train)
    else
      validate_array_of_entities!(picked_train.wagons, 'у поезда  вагонов')
      add_wagon(picked_train)
    end
  rescue TrainException => e
    puts e.message
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

  def add_route_to_train(picked_train)
    validate_array_of_entities!(routes, 'маршрутов')

    items_list(routes, 'маршрутов')
    picked_route = gets.chomp.to_i
    picked_train.add_route(routes[picked_route])
  end

  def pick_train
    validate_array_of_entities!(trains, 'поездов')
    items_list(trains, 'поездов')

    picked_train_index = gets.chomp.to_i
    trains[picked_train_index]
  end

  def move_train(train, station = :back)
    station == :back ? train.move_previous_station : train.move_next_station
  rescue TrainException => e
    puts e.message
  end
end
