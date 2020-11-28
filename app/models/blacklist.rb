class Blacklist < ApplicationRecord

  #### Relationships
  belongs_to :user, dependent: :destroy

  #### Validations
  validates :user_id,
            :category_id,
            presence: true

end
