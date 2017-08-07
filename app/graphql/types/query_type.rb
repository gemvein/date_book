Types::QueryType = GraphQL::ObjectType.define do
  name "Dog Training Log API"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # Current user hack // Check GraphQL controller
  field :profile do
    type Types::ProfileType
    description "Current signed in User"
    resolve -> (obj, args, ctx) {
      ctx[:current_user] ? ctx[:current_user] : User.new
    }
  end

  field :events do
    type types[Types::EventType]
    description "Find a event by slug_fragment and match_mode"
    argument :ending_after, types.String # Start date
    argument :starting_before, types.String # End date
    resolve ->(obj, args, ctx) {
      ending_after = (
        args[:ending_after]&.to_datetime ||
          Time.now.beginning_of_month
      )
      starting_before = (
       args[:starting_before]&.to_datetime ||
         Time.now.beginning_of_month.next_month
      )
      Event
        .accessible_by(current_ability)
        .starting_before(starting_before)
        .ending_after(ending_after)
    }
  end
end
