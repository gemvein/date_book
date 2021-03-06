# frozen_string_literal: true

FactoryGirl.define do
  factory :event do
    description { "<p>#{Faker::Lorem.paragraphs(2).join('</p><p>')}</p>" }
    calendar { Calendar.friendly.find('admin-calendar') }
    transient do
      owner { User.find_by_name('Admin User') }
    end
    after(:create) do |record, evaluator|
      evaluator.owner.add_role(:owner, record)
    end
  end
end
