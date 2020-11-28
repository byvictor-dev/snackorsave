FactoryBot.define do

  factory :blacklist do
    title { Faker::Company.bs }
    category { 'Bakery' }
    blocked { true }
    user { create :user }
  end

end
