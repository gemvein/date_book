Types::DateTimeType = GraphQL::ScalarType.define do
  name "DateTime"
  description "Date with Time"

  coerce_input ->(value, ctx) { Time.at(Float(value)) }
  coerce_result ->(value, ctx) { "#{value.to_date} #{value.strftime('%I:%M %p')}" }
end