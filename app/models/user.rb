# +User+ Model
class User < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +User+ unique ID
  # @!attribute name
  #   @return [String] User first name
  # @!attribute email
  #   @return [String] Email address
  # @!attribute profile
  #   @return [Integer] User profile
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date
  # Include default devise modules.
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
  include DeviseTokenAuth::Concerns::User

  # validations
  validates :name,
            :email,
            :profile, presence: true
end
