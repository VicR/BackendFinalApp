FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.unique.email }
    profile User::Profile::MANAGER
    password '12345678'
    confirmed_at Time.zone.now
  end
end
