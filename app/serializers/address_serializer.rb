class AddressSerializer < ActiveModel::Serializer
  attributes :street, :suite, :city, :zipcode
end
