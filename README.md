# README

# Ruby on Rails Demo Library App

A simple Ruby on Rails demo library app with SQLite, showcasing CRUD operations and a RESTful API with Swagger documentation.

## Getting Started

### Clone the repository
First clone the repo on your local computer

### Install dependencies
```bash
bundle install
```

### Database setup and seed data
Since we are using SQLite database, run the following commands to create the database and populate it with test data

```bash
rails db:create
rails db:migrate
rails db:seed
```

### Start the Rails server and navigate to Swagger docs
```bash
rails s
```
And navigate to {defaultport}/api-docs/index.html to see swagger definition and test the routes

### Authentication

For authentication, use the following credentials:

- **Username:** Any username (e.g., for getting users).
- **Password:** "password"

To access routes that require an employee role (e.g., create and get all loans), use a user with the role "employee".
