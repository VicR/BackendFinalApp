# +ProductSale+ Serializer
class ProductSaleSerializer < ApplicationSerializer
  attributes :sale_date,
             :quantity,
             :product_id,
             :client_id
end
