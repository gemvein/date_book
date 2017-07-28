# frozen_string_literal: true

module DateBook
  # DateBook Ability model
  module Ability
    include CanCan::Ability

    def initialize_date_book(user)
      if user.has_role? :admin
        can :manage, :all
      else
        can :read, Event
        can :manage, Event, id: Event.with_role(:owner, user).ids
      end
    end
  end
end
