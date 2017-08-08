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

  def self.weekdays
    @weekdays ||= Date::DAYNAMES
                  .map
                  .with_index do |x, i|
                    OpenStruct.new(id: i, name: x, slug: x.downcase)
                  end
                  .sort_by do |value|
      (value.id - week_start_index) % 7
    end
  end

  def self.week_start_index
    @week_start_index ||= Date::DAYNAMES.find_index(configuration.week_starts_on)
  end

  # DateBook Configuration
  class Configuration
    attr_accessor(
      :week_starts_on,
      :rules,
      :duration_units
    )

    def initialize
      self.week_starts_on = 'Sunday'
      self.rules = %w[singular daily weekly monthly]
      self.duration_units = %w[years months weeks days hours minutes seconds]
    end
  end
end
