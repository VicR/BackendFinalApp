# +ProductAdquisition+ Model
class ProductAdquisition < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +ProductAdquisition+ unique ID
  # @!attribute adquisition_date
  #   @return [Timestamp] Date-time of transaction (ISO 8601)
  # @!attribute quantity
  #   @return [Integer] Amount of products acquired
  # @!attribute product_id
  #   @return [Integer] Parent +Product+ id
  # @!attribute provider_id
  #   @return [Integer] Parent +Provider+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  belongs_to :provider
  belongs_to :product

  # validations
  validates :adquisition_date,
            :quantity, presence: true
end
