class Blacklist < ApplicationRecord

  #### Relationships
  belongs_to :user, dependent: :destroy
  has_one :merchant_category

  #### Validations
  validates :user_id,
            :merchant_name,
            presence: true

end
