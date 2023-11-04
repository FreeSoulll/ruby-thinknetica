require_relative '../modules/company_manufacture'

class Wagon
  include CompanyManufacture
  def type
    raise NotImplementedError
  end
end
