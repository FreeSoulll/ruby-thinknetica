require_relative '../modules/company_manufacture'
require_relative '../modules/instance_counter'
require_relative '../modules/validatable'
require_relative '../custom_errors'

class Train
  include CompanyManufacture
  include InstanceCounter
  include Validatable
  attr_reader :number, :route, :speed, :current_station, :wagons

  TRAIN_NUMBER_FORMAT = /^[a-z0-9]{3}-*[a-zA-Z0-9]{2}$/.freeze

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @wagons = []
    @@trains << self
    register_instance
  end

  def type
    raise NotImplementedError
  end

  def add_route(route)
    @route = route
    self.current_station = route.list_stations[0]
    current_station.add_train(self)
  end

  def add_wagon(wagon)
    raise TrainInMotion unless speed.zero?
    raise WrongTrainType unless wagon.type == type

    wagons << wagon
  end

  def remove_wagon(wagon)
    raise TrainInMotion unless speed.zero?
    raise TrainNotIncludeWagons unless wagons.include?(wagon)

    wagons.delete(wagon)
  end

  def wagons_info(&block)
    wagons.each { |wagon| block.call(wagon) }
  end

  def next_station
    raise EmpyTrainRoute if route.nil?

    new_station_index = route.list_stations.index(current_station) + 1
    return unless new_station_index <= route.list_stations.length - 1

    route.list_stations[new_station_index]
  end

  def previous_station
    raise EmpyTrainRoute if route.nil?

    new_station_index = route.list_stations.index(current_station) - 1
    return unless new_station_index > -1

    route.list_stations[new_station_index]
  end

  def move_next_station
    raise AlreadyLastStation unless next_station

    current_station.go_train(self)
    self.current_station = next_station
    current_station.add_train(self)
  end

  def move_previous_station
    raise AlreadyFirstStation unless previous_station

    current_station.go_train(self)
    self.current_station = previous_station
    current_station.add_train(self)
  end

  # Даныне методы скорее всего будут юзаться внутри класса, так что вынес их сюда
  protected

  attr_writer :speed, :current_station, :wagons

  def validate!
    raise ValidationError, 'Номер указан не в правильном формате' if number !~ TRAIN_NUMBER_FORMAT
  end

  def gain_speed(speed)
    self.speed += speed
  end

  def stop
    self.speed = 0
  end
end
