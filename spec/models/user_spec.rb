RSpec.describe 'Users API', type: :request do
  describe 'GET /users' do
    before do
      create_list(:user, 10)
    end

    it 'returns all users' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /users/search' do
    before do
    create(:user, name: 'John Doe', email: 'john@example.com')
    end

    it 'returns users that match the search criteria' do
      get '/users/search', params: { name: 'John Doe' }
      expect(response).to have_http_status(:success)
      expect(json.size).to eq(1)
      expect(json.first['name']).to eq('John Doe')
    end
  end
end
