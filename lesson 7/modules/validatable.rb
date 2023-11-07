module  Validatable
  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise NotImplementedError
  end
end
