# +Product+ Model
class Product < ApplicationRecord
  # @!attribute id
  #   @return [Integer] +Product+ unique ID
  # @!attribute model
  #   @return [String] Model of product
  # @!attribute price
  #   @return [Decimal] Price in pesos
  # @!attribute inventory
  #   @return [Integer] Amount of products in stock
  # @!attribute product_type
  #   @return [Integer] Specifies type of product
  # @!attribute high_tech
  #   @return [Boolean] Specifies if product is high tech
  # @!attribute rentable
  #   @return [Boolean] Specifies if product can be rented
  # @!attribute created_at
  #   @return [Date] Creation Date
  # @!attribute updated_at
  #   @return [Date] Last update Date
  # relations
  has_many :characteristics, dependent: :destroy
  # has_many :product_adquisitions, dependent: :destroy
  # has_many :product_sales, dependent: :destroy
  # has_many :rent_products, dependent: :destroy
  # has_many :high_tech_products, dependent: :destroy

  # validations
  validates :model,
            :price,
            :product_type,
            :inventory, presence: true
  validates :price,
            :inventory, presence: true, numericality: true
  validates :high_tech,
            :rentable, inclusion: { in: [true, false] }

  # +ProductType+ Module
  module ProductType
    CPU = 0
    PRINTER = 1
    MONITOR = 2
    HDD = 3
    OTHER = 4
  end
end
