# frozen_string_literal: true

module DateBook
  # Mixin to allow acts_as_schedule behavior in Schedule model
  module ActsAsSchedule
    def acts_as_schedule(_options = {})
      include InstanceMethods
    end

    # Instance Methods
    module InstanceMethods
      def duration_attributes
        OpenStruct.new count: duration_count, unit: duration_unit
      end

      def duration_attributes=(value)
        if value.is_a? Hash
          self.duration = value['count'].to_i.send(value['unit'].to_sym).to_i
        end
        super value
      end

      def duration_count
        duration / 1.send(duration_unit.singularize.to_sym).to_i
      end

      def duration_unit
        return 'seconds' if duration.zero?
        DateBook
          .configuration
          .duration_units
          .select { |x| unit_matches? x }
          .first || 'seconds'
      end

      def human_date
        I18n.localize date, format: :human_date
      end

      def human_time
        I18n.localize time, format: :human_time
      end

      private

      def unit_matches?(unit)
        (duration % 1.send(unit.singularize.to_sym).to_i).zero?
      end
    end
  end
end
