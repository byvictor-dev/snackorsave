class MerchantCategory < ApplicationRecord
  has_many :blacklists, dependent: :destroy
  has_many :transaction_attempts, dependent: :destroy

  def to_s
    description
  end
end
