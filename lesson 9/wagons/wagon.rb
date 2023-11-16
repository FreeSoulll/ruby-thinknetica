# frozen_string_literal: true

require_relative '../modules/company_manufacture'

class Wagon
  include CompanyManufacture

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def type
    raise NotImplementedError
  end
end
