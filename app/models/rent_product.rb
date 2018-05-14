# +RentProduct+ Model
class RentProduct < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +RentProduct+ unique ID
  # @!attribute price_hour
  #   @return [Decimal] Price per hour of rental
  # @!attribute product_id
  #   @return [Integer] Parent +Product+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date
  # relations
  belongs_to :product

  # validations
  validates :price_hour, presence: true, numericality: true
end
