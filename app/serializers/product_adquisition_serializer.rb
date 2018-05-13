# +ProductAdquisition+ Serializer
class ProductAdquisitionSerializer < ApplicationSerializer
  attributes :adquisition_date,
             :quantity,
             :product_id,
             :provider_id
end
