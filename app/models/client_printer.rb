# +ClientPrinter+ Model
class ClientPrinter < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +ClientPrinter+ unique ID
  # @!attribute adquisition_date
  #   @return [Timestamp] Date-time of printer adquisition (ISO 8601)
  # @!attribute client_id
  #   @return [Integer] Parent +Client+ id
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  belongs_to :client

  # validations
  validates :adquisition_date, presence: true
end
