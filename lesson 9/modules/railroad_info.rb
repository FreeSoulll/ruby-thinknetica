# frozen_string_literal: true

module RailRoadInfo
  private

  def items_list(entity, entity_name)
    puts "Вот список #{entity_name}, введите индекс нужного"
    entity.each_with_index { |item, index| puts "#{index}) - #{item}" }
  end

  def stations_list(sorted_stations)
    sorted_stations.each_with_index do |station, index|
      puts "#{index}) Название станции - #{station.name}, поезда на этой станции - #{station.trains}"
    end
  end

  def train_wagons_info(train, text)
    train.wagons_info do |wagon|
      wagon_free_space = wagon.type == :passenger ? wagon.free_places : wagon.free_volue
      puts "Номер вагона - #{wagon.number}, тип вагона - #{wagon.type}, #{text} - #{wagon_free_space}"
    end
  end

  def info_from_stations
    stations.each do |station|
      puts "Информация по станици #{station.name}"
      station.trains_info do |train|
        puts "Номер поезда - #{train.number}, тип - #{train.type}, количество вагонов - #{train.wagons.length}"
        train_wagons_info(train, 'свободное место')
      end
    end
  end

  def wagon_list_from_train
    validate_array_of_entities!(trains, 'поездов')
    items_list(trains, 'поездов')
    picked_train_index = gets.chomp.to_i
    picked_train = trains[picked_train_index]
    train_wagons_info(picked_train, 'свободных мест')
  end

  def info_for_create_wagon
    puts 'Укажите 1 если хотите создать пассажирский или любой другой символ, если хотите создать грузовой вагон'
    type_wagon = gets.chomp.to_i
    puts 'Укажите номер вагона'
    wagon_number = gets.chomp.to_i

    type_wagon == 1 ? puts('Укажите кол-во мест') : puts('Укажите кол-во объема')
    wagon_size = gets.chomp.to_i

    [type_wagon, wagon_number, wagon_size]
  rescue ValidationError => e
    puts e.message
    retry
  end
end
