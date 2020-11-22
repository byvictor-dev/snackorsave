class Blacklist < ApplicationRecord

  #### Relationships
  belongs_to :user, dependent: :destroy

  #### Validations
  validates :user_id,
            :merchant_name,
            presence: true

end
