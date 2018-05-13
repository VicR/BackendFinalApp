# +Client+ Serializer
class ClientSerializer < ApplicationSerializer
  attributes :name,
             :fathers_last,
             :mothers_last,
             :ine,
             :phone,
             :address,
             :user_id
end
