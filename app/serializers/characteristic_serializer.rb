# +Characteristic+ Serializer
class CharacteristicSerializer < ApplicationSerializer
  attributes :field,
             :value,
             :product_id
end
