DateBookSchema = GraphQL::Schema.define do
  # mutation(Types::MutationType)
  query(Types::QueryType)
  resolve_type ->(type, obj, ctx) do
    case obj
    when Profile
      Types::ProfileType
    when Calendar
      Types::CalendarType
    else
      raise("Unexpected object: #{obj}")
    end
  end
end
