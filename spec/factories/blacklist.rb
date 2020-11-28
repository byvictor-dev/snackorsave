FactoryBot.define do

  factory :blacklist do
    title             { Faker::Company.bs }
    merchant_category { create :merchant_category }
    blocked           { true }
    user              { create :user }
  end

end
