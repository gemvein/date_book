BasicBenchmark.new "Seeding #{Rails.env} Events" do
  FactoryGirl.create(
    :event,
    name: 'Monday',
    css_class: 'weekday',
    schedule_attributes: {
      rule: 'weekly',
      day: %w(monday),
      time: '00:00',
      duration: 1.day,
      all_day: true
    }
  )

  FactoryGirl.create(
    :event,
    name: 'The work week',
    css_class: 'week',
    schedule_attributes: {
      rule: 'weekly',
      day: %w(monday),
      time: '00:00',
      duration: 5.days,
      all_day: true
    }
  )

  FactoryGirl.create(
    :event,
    name: 'Breakfast',
    schedule_attributes: {
      rule: 'daily',
      time: '8:00 AM',
      duration: 1.hour
    }
  )

  FactoryGirl.create(
    :event,
    name: 'Midnight Pilates',
    schedule_attributes: {
      rule: 'daily',
      time: '11:30 PM',
      duration: 1.hour
    }
  )

  FactoryGirl.create(
    :event,
    name: 'Science Fiction Club',
    schedule_attributes: {
      rule: 'monthly',
      day_of_week: { tuesday: [ '1' ] },
      time: '5:00 PM',
      interval: 1,
      duration: 1.hour
    }
  )

end
