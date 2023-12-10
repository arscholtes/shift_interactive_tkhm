class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :phone, :company_name, :created_at, :updated_at

  has_one :address
end
