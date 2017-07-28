BasicBenchmark.new "Seeding #{Rails.env} Events" do
  FactoryGirl.create(
    :event,
    name: 'Monday',
    schedule_attributes: { rule: 'weekly', day: %w(monday), time: '00:00', duration: 1.day }
  )
  FactoryGirl.create(
    :event,
    name: 'Breakfast',
    schedule_attributes: { rule: 'daily', time: '8:00 AM', duration: 1.hour }
  )
end
