FactoryBot.define do

  factory :transaction_attempt do
    amount        { 10000 }
    category_id   { 1 }
    merchant_name { 'The Lord of War' }
    user          { create :user }
  end

end
