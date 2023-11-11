require_relative '../modules/company_manufacture'

class Wagon
  include CompanyManufacture

  attr_reader :number, :free_space

  def initialize(number, free_space)
    @number = number
    @free_space = free_space
  end

  def type
    raise NotImplementedError
  end
end
