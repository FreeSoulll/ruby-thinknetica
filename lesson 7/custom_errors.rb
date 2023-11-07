class TrainException < StandardError; end

class TrainInMotion < TrainException
  def initialize(msg = 'Поезд находится в движении, невозможно прицепить вагон')
    super
  end
end

class WrongTrainType < TrainException
  def initialize(msg = 'Поезд тип вагона не совпадает с типом поезда')
    super
  end
end

class TrainNotIncludeWagons < TrainException
  def initialize(msg = 'У поезда нет прицепленных вагонов')
    super
  end
end

class AlreadyLastStation < TrainException
  def initialize(msg = 'Это конечная станция')
    super
  end
end

class AlreadyFirstStation < TrainException
  def initialize(msg = 'Это начальная станция')
    super
  end
end

class EmpyTrainRoute < TrainException
  def initialize(msg = 'У поезда нет маршрута, добавьте маршрут')
    super
  end
end

class ValidationError < StandardError; end
