class UserSerializer < ActiveModel::Serializer
  attributes :firstname, :lastname, :borndate, :bornplace, :address, :phone_number, :email
  
  has_one: babysitter
  has_one: parent

end
