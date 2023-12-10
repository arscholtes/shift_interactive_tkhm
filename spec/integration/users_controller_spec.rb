# spec/integration/users_controller_spec.rb
require 'swagger_helper'

RSpec.describe 'Users API', type: :request do

  path '/users' do

    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'List of all users' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   email: { type: :string },
                   phone: { type: :string },
                   company_name: { type: :string },
                   address: {
                     type: :object,
                     properties: {
                       street: { type: :string },
                       suite: { type: :string },
                       city: { type: :string },
                       zipcode: { type: :string }
                     }
                   }
                 }
               }

        run_test!
      end
    end
  end

  path '/users/search' do

    get 'Searches for users based on criteria' do
      tags 'Users'
      produces 'application/json'
      parameter name: :name, in: :query, type: :string, required: false, description: 'Name of the user'
      parameter name: :email, in: :query, type: :string, required: false, description: 'Email of the user'
      parameter name: :phone, in: :query, type: :string, required: false, description: 'Phone number of the user'
      parameter name: :zipcode, in: :query, type: :string, required: false, description: 'Zip code of the user address'
      parameter name: :company_name, in: :query, type: :string, required: false, description: 'Company name of the user'
      parameter name: :street, in: :query, type: :string, required: false, description: 'Street of the user address'

      response '200', 'Users found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   email: { type: :string },
                   phone: { type: :string },
                   company_name: { type: :string },
                   address: {
                     type: :object,
                     properties: {
                       street: { type: :string },
                       suite: { type: :string },
                       city: { type: :string },
                       zipcode: { type: :string }
                     }
                   }
                 }
               }

        run_test!
      end

      response '404', 'No users found' do
        run_test!
      end

      response '400', 'Bad Request' do
        run_test!
      end
    end
  end
end
