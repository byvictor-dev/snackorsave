FactoryBot.define do

  factory :transaction_attempt do
    amount            { 10000 }
    merchant_category { create :merchant_category }
    merchant_name     { 'The Lord of War' }
    user              { create :user }
  end

end
