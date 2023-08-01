# README

# Agency of Learning's Pair App

## Prerequisites

To set up this project, you need to have the following software installed on your computer:

- Ruby 3.1.0
- Rails 7.0.0 or higher
- PostgreSQL 9.5 or higher
- Redis 7.0 or later
- Yarn or Npm
- [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) (Follow the link for installation instructions)

## 12factor Approach

This project follows the [12factor methodology](https://12factor.net/) for building software-as-a-service applications. Specifically, this project adheres to the following 12 factors:

- **Codebase:** One codebase tracked in version control, many deploys
- **Dependencies:** Explicitly declare and isolate dependencies
- **Config:** Store config in the environment
- **Backing services:** Treat backing services as attached resources
- **Build, release, run:** Strictly separate build and run stages
- **Processes:** Execute the app as one or more stateless processes
- **Port binding:** Export services via port binding
- **Concurrency:** Scale out via the process model
- **Disposability:** Maximize robustness with fast startup and graceful shutdown
- **Dev/prod parity:** Keep development, staging, and production as similar as possible
- **Logs:** Treat logs as event streams
- **Admin processes:** Run admin/management tasks as one-off processes

## Getting Started

To get started with this project, follow these steps:

1. Clone this repository to your local machine:

```bash
git clone git@github.com:agency-of-learning/PairApp.git
```

2. Navigate to the project directory:

```bash
cd PairApp
```

3. Run the setup script. This will install dependencies and create, migrate, and seed the database.

```bash
bin/setup
```

4. To start the project locally, run:

```bash
bin/dev
```

This will start the development server, the asset compiling for CSS and JS, and background worker. Open your web browser and go to http://localhost:3000 to see the application running.

## Working with Devise Invitable

If you need to work with the user registration/invitation process, follow these steps:

1. Make sure you are logged out of the application.

2. Open a Rails console session:

```bash
rails console
```

3. In the console, run the following command to invite a user:

```bash
User.invite!(email: <some_test_email>)
```

4. You can access the letter by opening http://localhost:3000/letter_opener (dev only).

5. Click the invite link to get to the sign-up page where you can set a password. This will create a fully active account with the provided email and password.

Note: This flow is only necessary if you're building something around the user registration/invitation process. If you just want to create users, you can use User.create(\*\*attrs) as usual.

## Contributing

If you want to contribute to this project, please follow these steps:

1. From your local clone, create a new branch for your changes:

```bash
git checkout -b your-feature-branch-name
```

2. Make your changes and commit them:

```bash
git add .
git commit -m "Add your commit message here"
```

3. Running Tests

```bash
  bundle exec rspec
```

4. Cleaning up before pushing

```bash
# lint ruby code
bundle exec rubocop -a

# lint javascript code
yarn eslint --fix
```

5. Push your changes to origin:

```bash
git push origin your-feature-branch-name
```

6. Create a new pull request on the original repository and wait for the maintainer to review and merge your changes.
