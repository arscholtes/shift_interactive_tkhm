# Rails API for User Management
- API Documentation: http://localhost:3000/api-docs/index.html
- Must start rails server in order to access
## Overview

This Rails API provides functionalities for managing users and their addresses. It includes creating, listing, searching, and handling user data with associated address information.

## Components

### Models

#### User
- Represents the users of the application.
- Attributes: `name`, `email`, `phone`, `company_name`, etc.
- Associations: Has one `Address`.

#### Address
- Stores address details for users.
- Attributes: `street`, `suite`, `city`, `zipcode`, etc.
- Associations: Belongs to `User`.

### Controllers

#### UsersController
- Manages user-related actions.
- Actions:
    - `index`: Lists all users with their addresses.
    - `search`: Searches for users based on various criteria (name, email, etc.).

### Factory Bot Configuration

- Factories for `User` and `Address` models for test data generation.
- Uses Faker for generating realistic test data.

### RSpec Tests

- Tests for `UsersController` covering various scenarios like fetching all users, searching with different criteria, and error handling.
- Utilizes Factory Bot for setting up test data.

### Error Handling and Security

- SQL Injection Protection: Implemented in `UsersController` to prevent SQL injection attacks.
- Validation of parameters to ensure only allowed fields are processed in search queries.

### Routes

- Standard RESTful routes for users.
- Additional route for searching users: `/users/search`.

### Database

- Uses SQLite for database management.
- Appropriate migrations for creating `users` and `addresses` tables with necessary fields.

### Miscellaneous

- Includes `rails_helper.rb` and `spec_helper.rb` for RSpec configurations.
- Uses Database Cleaner for maintaining a clean state in the test database between runs.

## Usage and Testing

- Run the server using `rails s` to start the application.
- Access the API endpoints (`/users`, `/users/search`) via HTTP requests.
- Run the test suite using `bundle exec rspec` to ensure all functionalities work as expected.

## Notes

- Ensure all dependencies are installed, especially for testing (RSpec, Factory Bot, Faker).
- Review and update configurations in `rails_helper.rb` as needed, especially for specific testing needs.
- The API currently provides basic search functionality; consider enhancing it for more complex queries.
