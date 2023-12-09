class UsersController < ApplicationController
  def search
    search_params = params.permit(:name, :email, :phone, :zipcode, :company_name, :street)
    user_query = build_user_query(search_params)
    address_query = build_address_query(search_params)

    users = User.joins(:address).where(user_query).where(addresses: address_query)
    render json: users
  end

  private

  def build_user_query(params)
    query = {}
    query[:name] = params[:name] if params[:name].present?
    query[:email] = params[:email] if params[:email].present?
    query[:phone] = params[:phone] if params[:phone].present?
    query[:company_name] = params[:company_name] if params[:company_name].present?
    query
  end

  def build_address_query(params)
    query = {}
    query[:street] = params[:street] if params[:street].present?
    query[:zipcode] = params[:zipcode] if params[:zipcode].present?
    query
  end
end
