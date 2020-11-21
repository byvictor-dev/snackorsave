FactoryBot.define do

  factory :blacklist do
    title { Faker::Company.bs }
    merchant_name { Faker::Company.name }
    blocked { true }
    user { create :user }
  end

end
