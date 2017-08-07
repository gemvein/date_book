DateBookSchema = GraphQL::Schema.define do
  # mutation(Types::MutationType)
  query(Types::QueryType)
  resolve_type ->(type, obj, ctx) do
    case obj
    when Profile
      Types::ProfileType
    when Calendar
      Types::CalendarType
    when Event
      Types::EventType
    when EventOccurrence
      Types::EventOccurrenceType
    else
      raise("Unexpected object: #{obj}")
    end
  end
end
