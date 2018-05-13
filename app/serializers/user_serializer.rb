# +User+ Serializer
class UserSerializer < ApplicationSerializer
  attributes :name,
             :email,
             :profile
end
