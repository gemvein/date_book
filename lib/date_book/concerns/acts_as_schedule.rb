module DateBook
  module ActsAsSchedule
    def acts_as_schedule(options = {})
      include InstanceMethods
    end

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
        return 'seconds' if duration == 0
        DateBook.configuration.duration_units.select { |x| is_unit? x }.first || 'seconds'
      end

      def human_date
        I18n.localize date, format: :human_date
      end

      def human_time
        I18n.localize time, format: :human_time
      end

      private

      def is_unit?(unit)
        duration % 1.send(unit.singularize.to_sym).to_i == 0
      end
    end

  end
end