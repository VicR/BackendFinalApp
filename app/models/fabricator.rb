# +Fabricator+ Model
class Fabricator < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Fabricator+ unique ID
  # @!attribute name
  #   @return [String] Name of of fabricator
  # @!attribute address
  #   @return [String] Address
  # @!attribute employee_qty
  #   @return [Integer] Number of employees hired
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date

  # relations
  has_many :high_tech_products, dependent: :destroy

  # validations
  validates :name,
            :address, presence: true
  validates :employee_qty, presence: true, numericality: true
end
