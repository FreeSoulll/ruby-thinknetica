module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_reader :instances

    private

    attr_writer :instances
  end

  module InstanceMethods
    protected

    def register_instance
      instances = self.class.instances.nil? ? 1 : self.class.instances + 1
      self.class.send(:instances=, instances)
    end
  end
end
