# frozen_string_literal: true

# DateBook Module
module DateBook
  def self.configure(configuration = DateBook::Configuration.new)
    block_given? && yield(configuration)
    @configuration = configuration
  end

  def self.configuration
    @configuration ||= DateBook::Configuration.new
  end

  # DateBook Configuration
  class Configuration
    attr_accessor(
      :nothing
    )

    def initialize
      self.nothing = 'TODO'
    end
  end
end
