require_relative './modules/instance_counter'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  @@all_staions = []

  def self.all
    @@all_staions
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_staions << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_train(train)
    trains << train
  end

  def sorted_trains(type)
    trains.select { |train| train.type == type }
  end

  def go_train(train)
    trains.delete(train)
  end

  protected

  def validate!
    raise 'Имя не может быть пустым' if name.nil?
  end
end
