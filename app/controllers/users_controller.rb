class UsersController < ApplicationController
  # GET /users
  def index
    users = User.all.includes(:address)
    render json: users, include: :address
  end

  # GET /users/search
  def search
    search_params = user_search_params
    users = User.joins(:address).where(build_user_query(search_params)).where(addresses: build_address_query(search_params))
    render json: users
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end

  def user_search_params
    params.permit(:name, :email, :phone, :zipcode, :company_name, :street)
  end

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
