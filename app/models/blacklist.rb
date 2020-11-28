class Blacklist < ApplicationRecord

  #### Relationships
  belongs_to :user, dependent: :destroy
  has_one :merchant_category

  #### Validations
  validates :user_id,
            :category_id,
            presence: true

end
