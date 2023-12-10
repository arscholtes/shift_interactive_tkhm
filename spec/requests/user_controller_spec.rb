# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    context "when there are users" do
      before do
        create_list(:user, 5)
      end

      it "returns all users" do
        get :index
        expect(response).to be_successful
        parsed_response = JSON.parse(response.body)

        expect(parsed_response.count).to eq(5)
      end
    end

    context "when there are no users" do
      it "returns an empty array" do
        get :index
        expect(response).to be_successful

        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_empty
      end
    end
  end

  describe "GET #search" do
    before do
      create(:user, name: 'John Doe', email: 'john@example.com')
      create(:user, name: 'Jane Smith', email: 'jane@example.com')
    end

    context "when searching by name" do
      it "returns users matching the name" do
        get :search, params: { name: 'John Doe' }
        expect(response).to be_successful

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(1)
        expect(parsed_response[0]['name']).to eq('John Doe')
      end
    end

    context "when searching with no matches" do
      it "returns a not found status" do
        get :search, params: { name: 'Nonexistent Name' }
        expect(response).to have_http_status(:not_found)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq('No users found matching the search criteria')
      end
    end

    context "when searching by email" do
      it "returns users matching the email" do
        get :search, params: { email: 'john@example.com' }

        expect(response).to have_http_status(:success)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(1)
        expect(parsed_response[0]['email']).to eq('john@example.com')
      end
    end

    context "when searching with a very long string" do
      it "handles the search gracefully" do
        long_string = 'a' * 500
        get :search, params: { name: long_string }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when searching with special characters" do
      it "handles the search gracefully" do
        get :search, params: { name: 'John @Doe!' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when an SQL injection attack is attempted" do
      it "does not succumb to SQL injection" do
        get :search, params: { name: "' UPDATE '1'='1" }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when searching with multiple parameters" do
      it "returns users matching all criteria" do
        get :search, params: { name: 'John Doe', email: 'john@example.com' }
        expect(response).to be_successful

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.count).to eq(1)
      end
    end

    context "when a matching user is found" do
      let!(:user) { create(:user, name: 'Remy Remington', email: 'remy@example.com') }
      let!(:address) { create(:address, user: user) }

      it "returns all data associated with the user" do
        get :search, params: { name: 'Remy Remington' }
        expect(response).to be_successful

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.length).to eq(1)
        user_response = parsed_response.first
        puts user_response

        expect(user_response['id']).to eq(user.id)
        expect(user_response['name']).to eq(user.name)
        expect(user_response['email']).to eq(user.email)
        expect(user_response['address']['id']).to eq(address.id)
        expect(user_response['address']['street']).to eq(address.street)
      end
    end
  end
end
