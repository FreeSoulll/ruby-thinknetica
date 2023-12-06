# frozen_string_literal: true

class User < Player
  def initialize(name)
    super()
    @name = name
  end
end
