# app/serializers/user_serializer.rb

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :company_name
  has_one :address
end
