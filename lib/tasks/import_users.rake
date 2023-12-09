# lib/tasks/import_users.rake

require 'httparty'

namespace :db do
  desc "Import users from the JSONPlaceholder API"
  task import_users: :environment do
    url = 'https://jsonplaceholder.typicode.com/users/'
    response = HTTParty.get(url)

    if response.success?
      users = JSON.parse(response.body)

      users.each do |user_data|
        user = User.create(
          name: user_data['name'],
          email: user_data['email'],
          phone: user_data['phone'],
          company_name: user_data['company']['name']
        )

        Address.create(
          street: user_data['address']['street'],
          suite: user_data['address']['suite'],
          city: user_data['address']['city'],
          zipcode: user_data['address']['zipcode'],
          user: user
        )
      end
    else
      puts "Failed to retrieve data: #{response.code}"
    end
  end
end
