# frozen_string_literal: true

# CanCanCan Ability class
class Ability
  include CanCan::Ability
  include DateBook::Ability

  def initialize(user)
    user ||= User.new # anonymous user (not logged in)

    # Rails Application's initialization could go here.
    # can :manage, Group, user: user

    initialize_date_book(user)
  end
end
