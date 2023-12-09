# spec/controllers/users_controller_spec.rb

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns all users" do
      get :index
      expect(response).to be_successful
      # Add more assertions based on your application's needs
    end
  end
  
end
