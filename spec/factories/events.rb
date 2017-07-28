FactoryGirl.define do
  factory :event, class: 'DateBook::Event' do
    description { "<p>#{Faker::Lorem.paragraphs(2).join('</p><p>')}</p>" }
  end
end
