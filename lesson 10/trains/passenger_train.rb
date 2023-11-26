# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :format, TRAIN_NUMBER_FORMAT

  def type
    :passenger
  end
end
