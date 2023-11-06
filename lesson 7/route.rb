require_relative './modules/instance_counter'

class Route
  include InstanceCounter
  attr_reader :list_stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_stations = [@first_station, @last_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_station(station)
    list_stations.insert(-2, station)
  end

  def remove_station(station)
    list_stations.delete(station)
  end

  protected

  def validate!
    raise 'В маршруте при создании  должны быть начальная станция и конечная' if list_stations.empty?
  end
end
