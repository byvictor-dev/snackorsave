class Blacklist < ApplicationRecord

  #### Relationships
  belongs_to :merchant_category
  belongs_to :user, dependent: :destroy

  #### Validations
  validates :user_id,
            :merchant_category_id,
            presence: true

end
