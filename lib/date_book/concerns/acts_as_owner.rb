# frozen_string_literal: true

module DateBook
  module ActsAsOwner
    def acts_as_owner(_options = {})
      include InstanceMethods
      extend ClassMethods
    end

    module InstanceMethods
      def calendars
        Calendar.with_role(:owner, self)
      end
    end

    module ClassMethods
    end
  end
end
