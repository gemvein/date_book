# frozen_string_literal: true

module DateBook
  # Mixin to allow acts_as_owner behavior in User model
  module ActsAsOwner
    def acts_as_owner(_options = {})
      include InstanceMethods
    end

    # Instance Methods
    module InstanceMethods
      def calendars
        Calendar.with_role(:owner, self)
      end
    end
  end
end
