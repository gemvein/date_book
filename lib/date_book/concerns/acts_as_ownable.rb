# frozen_string_literal: true

module DateBook
  # Mixin to allow acts_as_ownable behavior in Calendar and Event models
  module ActsAsOwnable
    def acts_as_ownable(_options = {})
      # Rolify Gem
      resourcify

      scope :readable_by, ->(user) { accessible_by(::Ability.new(user)) }

      include InstanceMethods
    end

    # Instance Methods
    module InstanceMethods
      def owners
        User.with_role(:owner, self)
      end

      def owners=(revised_owners)
        # Remove owners not listed in new value
        owners.each do |owner|
          next if revised_owners.include? owner
          owner.remove_role(:owner, self)
        end
        # Add owners not previously held
        revised_owners.each do |revised_owner|
          next if owners.include? revised_owner
          revised_owner.add_role :owner, self
        end
      end
    end
  end
end
