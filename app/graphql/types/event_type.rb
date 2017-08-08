# frozen_string_literal: true

Types::EventType = GraphQL::ObjectType.define do
  name 'Event'
  description 'DateBook Events'

  field :id, !types.ID
  field :calendar, Types::CalendarType
  field :name, types.String
  field :slug, types.String
  field :url, types.String
  field :description, types.String
  field :css_class, types.String
  field :text_color, types.String
  field :background_color, types.String
  field :border_color, types.String
  field :start, types.String
  field :end, types.String
  field :duration, types.String
  field :all_day, types.Boolean

  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
end
