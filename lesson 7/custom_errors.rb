class TrainInMotion < StandardError
  def initialize(msg = 'Поезд находится в движении, невозможно прицепить вагон')
    super
  end
end

class TrainType < StandardError
  def initialize(msg = 'Поезд тип вагона не совпадает с типом поезда')
    super
  end
end

class TrainWagonsInclude < StandardError
  def initialize(msg = 'У поезда нет прицепленных вагонов')
    super
  end
end

class LastStation < StandardError
  def initialize(msg = 'Это конечная станция')
    super
  end
end

class FirstStation < StandardError
  def initialize(msg = 'Это начальная станция')
    super
  end
end

class TrainRoute < StandardError
  def initialize(msg = 'У поезда нет маршрута, добавьте маршрут')
    super
  end
end
