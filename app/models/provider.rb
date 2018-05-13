# +Provider+ Model
class Provider < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Provider+ unique ID
  # @!attribute name
  #   @return [String] Name of provider
  # @!attribute address
  #   @return [String] Address
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  has_many :product_adquisitions, dependent: :destroy

  # validations
  validates :name,
            :address, presence: true
end
