BasicBenchmark.new "Seeding #{Rails.env} Users" do
  FactoryGirl.create(
    :user,
    name: 'Admin User'
  ).add_role(:admin)

  FactoryGirl.create(
    :user,
    name: 'Regular User'
  )

  FactoryGirl.create(
    :user,
    name: 'Other User'
  )
end