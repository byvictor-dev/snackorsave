class TransactionAttempt < ApplicationRecord
  belongs_to :merchant_category
  belongs_to :user

end
