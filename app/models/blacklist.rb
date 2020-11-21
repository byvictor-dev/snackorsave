class Blacklist < ApplicationRecord

  #### Relationships
  belongs_to :user

  #### Validations
  validates :user_id,
            :merchant_name,
            presence: true

end
