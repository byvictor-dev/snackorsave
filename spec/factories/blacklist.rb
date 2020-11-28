FactoryBot.define do

  factory :blacklist do
    title { Faker::Company.bs }
    category { 1 }
    blocked { true }
    user { create :user }
  end

end
