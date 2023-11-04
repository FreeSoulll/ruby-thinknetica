module InstanceCounter

  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      instances = self.class.instances + 1
      self.class.send(:instances, instances)
    end
  end
end
