# frozen_string_literal: true

after :users do
  BasicBenchmark.new "Seeding #{Rails.env} Calendars" do
    FactoryGirl.create(
      :calendar,
      name: 'Admin Calendar',
      css_class: 'admin-calendar'
    )
    FactoryGirl.create(
      :calendar,
      name: 'Regular Calendar',
      css_class: 'regular-calendar',
      owner: User.find_by_name('Regular User')
    )
    FactoryGirl.create(
      :calendar,
      name: 'Other Calendar',
      css_class: 'other-calendar',
      owner: User.find_by_name('Other User')
    )
  end
end
