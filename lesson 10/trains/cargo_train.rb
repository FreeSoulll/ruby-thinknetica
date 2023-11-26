# frozen_string_literal: true

class CargoTrain < Train
  validate :number, :format, TRAIN_NUMBER_FORMAT

  def type
    :cargo
  end
end
