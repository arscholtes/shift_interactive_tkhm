class UsersController < ApplicationController
  # GET /users
  def index
    users = User.all.includes(:address)
    render json: users
  end

  def search
    if sql_injection_attempted?(user_search_params) || !valid_params?(user_search_params)
      render json: { error: 'Bad Request' }, status: :bad_request
      return
    end

    users = User.where(sanitize_params(user_search_params)).includes(:address)

    if users.empty?
      render json: { error: 'No users found matching the search criteria' }, status: :not_found
    else
      render json: users
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def sql_injection_attempted?(params)
    injection_patterns = [/--/, /;/, /select\b/i, /insert\b/i, /update\b/i, /delete\b/i, /drop\b/i]
    params.values.any? do |value|
      injection_patterns.any? { |pattern| value.to_s.match(pattern) }
    end
  end

  def sanitize_params(params)
    allowed_params = [:name, :email, :phone, :zipcode, :company_name, :street]
    params.slice(*allowed_params)
  end

  def valid_params?(params)
    allowed_params = [:name, :email, :phone, :zipcode, :company_name, :street]
    params.keys.all? { |key| allowed_params.include?(key.to_sym) }
  end

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end

  def user_search_params
    params.permit(:name, :email, :phone, :zipcode, :company_name, :street)
  end
end
