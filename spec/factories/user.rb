FactoryBot.define do

  factory :user do
    email                 { Faker::Internet.email }
    password              { 'letmein' }
    password_confirmation { 'letmein' }
    confirmed_at          { 2.hours.ago }
  end

end
