# +Product+ Serializer
class ProductSerializer < ApplicationSerializer
  attributes :product_type,
             :model,
             :price,
             :inventory,
             :high_tech,
             :rentable
end
