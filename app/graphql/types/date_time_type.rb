# frozen_string_literal: true

Types::DateTimeType = GraphQL::ScalarType.define do
  name 'DateTime'
  description 'Date with Time'

  coerce_input ->(value, _ctx) { Time.at(Float(value)) }
  coerce_result(lambda do |value, _ctx|
    "#{value.to_date} #{value.strftime('%I:%M %p')}"
  end)
end
