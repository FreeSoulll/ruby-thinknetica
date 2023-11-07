module  Validatable
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def valid?
      self.class.validate!
      true
    rescue
      false
    end

    protected

    def validate!
      raise NotImplementedError
    end
  end
end
