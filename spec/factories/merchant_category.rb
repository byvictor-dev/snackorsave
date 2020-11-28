FactoryBot.define do

  factory :merchant_category do
    description { Faker::Company.industry.downcase }
  end

end
