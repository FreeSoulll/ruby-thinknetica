# frozen_string_literal: true

class TrainException < StandardError; end

class TrainInMotion < TrainException
  def initialize(msg = 'The train is in motion, it is impossible to attach the wagon')
    super
  end
end

class WrongTrainType < TrainException
  def initialize(msg = 'The type of wagon does not match the type of train')
    super
  end
end

class TrainNotIncludeWagons < TrainException
  def initialize(msg = 'The train has no attached wagons')
    super
  end
end

class AlreadyLastStation < TrainException
  def initialize(msg = 'This is the terminal station')
    super
  end
end

class AlreadyFirstStation < TrainException
  def initialize(msg = 'This is the initial station')
    super
  end
end

class EmpyTrainRoute < TrainException
  def initialize(msg = 'The train does not have a route, add a route')
    super
  end
end

class WagonException < StandardError; end

class NotEnoughVolue < WagonException
  def initialize(msg = 'The volume is too large, there is no such free volume')
    super
  end
end

class NotEnoughPlace < WagonException
  def initialize(msg = 'There are no seats anymore')
    super
  end
end

class ValidationError < StandardError; end
