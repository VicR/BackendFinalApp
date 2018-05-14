# +HighTechProduct+ Model
class HighTechProduct < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +HighTechProduct+ unique ID
  # @!attribute country
  #   @return [String] Country of origin
  # @!attribute fabrication_date
  #   @return [Date] Date of fabrication (ISO 8601)
  # @!attribute product_id
  #   @return [Integer] Parent +Product+ id
  # @!attribute fabricator_id
  #   @return [Integer] Parent +Fabricator+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  belongs_to :product
  belongs_to :fabricator

  # validations
  validates :country,
            :fabrication_date, presence: true
end
