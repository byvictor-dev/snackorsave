FactoryBot.define do

  factory :blacklist do
    title       { Faker::Company.bs }
    category_id { 1 }
    blocked     { true }
    user        { create :user }
  end

end
