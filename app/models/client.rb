# +Client+ Model
class Client < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Client+ unique ID
  # @!attribute name
  #   @return [String] First name
  # @!attribute fathers_last
  #   @return [String] Father's last name
  # @!attribute mothers_last
  #   @return [String] Mother's last name
  # @!attribute ine
  #   @return [String] INE digits
  # @!attribute phone
  #   @return [String] Phone number
  # @!attribute address
  #   @return [String] Home address
  # @!attribute user_id
  #   @return [Integer] Parent +User+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date
  # relations
  belongs_to :user
  has_many :client_services, dependent: :destroy
  has_many :client_printers, dependent: :destroy
  has_many :product_sales, dependent: :destroy

  # validations
  validates :name,
            :fathers_last,
            :mothers_last,
            :ine,
            :phone,
            :address, presence: true
end
