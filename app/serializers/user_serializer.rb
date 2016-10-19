class UserSerializer < ActiveModel::Serializer
  attributes :firstname, :lastname
  #virtual attributes
end
