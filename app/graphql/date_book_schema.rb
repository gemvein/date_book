# frozen_string_literal: true

DateBookSchema = GraphQL::Schema.define do
  # mutation(Types::MutationType)
  query(Types::QueryType)

  rescue_from ActiveRecord::RecordInvalid, &:message
  rescue_from ActiveRecord::Rollback, &:message
  rescue_from StandardError, &:message
  rescue_from ActiveRecord::RecordNotUnique, &:message
  rescue_from ActiveRecord::RecordNotFound, &:message

  # Create UUIDs by joining the type name & ID, then base64-encoding it
  id_from_object ->(object, type_definition, query_ctx) {
    "#{object.class.name}-#{object.id}"
  }

  object_from_id ->(id, query_ctx) {
    model_name, item_id = split(id, '-')
    model_name.constantize.find(item_id)
  }

  resolve_type(lambda do |_type, obj, _ctx|
    case obj
    when Calendar
      Types::CalendarType
    when Event
      Types::EventType
    when EventOccurrence
      Types::EventOccurrenceType
    else
      raise("Unexpected object: #{obj}")
    end
  end)
end
