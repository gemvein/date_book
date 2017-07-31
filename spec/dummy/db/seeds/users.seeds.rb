BasicBenchmark.new "Seeding #{Rails.env} Users" do
  FactoryGirl.create(
    :user,
    name: 'Admin User'
  ).add_role(:admin)
end