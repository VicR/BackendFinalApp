# +HighTechProduct+ Serializer
class HighTechProductSerializer < ApplicationSerializer
  attributes :country,
             :fabrication_date,
             :product_id,
             :fabricator_id
end
