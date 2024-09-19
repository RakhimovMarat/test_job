FactoryBot.define do
  factory :user do
    name        { Faker::Name.first_name }
    surname     { Faker::Name.last_name }
    patronymic  { Faker::Name.middle_name }
    email       { Faker::Internet.email}
    age         { Faker::Number.between(from: 1, to: 90) }
    nationality { Faker::Nation.nationality }
    country     { Faker::Address.country }
    gender      { Faker::Gender.binary_type.downcase }
    full_name   { "#{surname} #{name} #{patronymic}" }
  end
end
