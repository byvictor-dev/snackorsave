class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :confirmable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable

  has_many :blacklists
  has_many :transaction_attempts

end
