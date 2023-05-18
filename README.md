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

1.Clone the forked repository to your local machine:

```bash
git clone git@github.com:[YOUR-USERNAME]/PairApp.git
```

2. Navigate to the project directory:

```bash
cd PairApp
```

3. Install the required dependencies:

```bash
bundle install
# if you use npm, then run npm install
yarn install
```

4. Create the database and run migrations:

```bash
rails db:create
rails db:migrate
```

5. Create a .env file in the root directory of the project with the following content:

```bash
AUTH0_SECRET=your-auth0-secret
```

Replace `your-auth0-secret` with the actual secret for your Auth0 application. If you are working with Agency of Learning, you can reach out to Dave and he will provide you with those credentials.

6. To start the project locally, run:

```bash
bin/dev
```

This will start the development server and background worker. Open your web browser and go to http://localhost:3000 to see the application running.

## Contributing

If you want to contribute to this project, please follow these steps:

1. Fork this repository to your own GitHub account.

2. Clone the forked repository to your local machine:

```bash
git clone https://github.com/your-username/PairApp.git
```

3. Create a new branch for your changes:

```bash
git checkout -b your-feature-branch-name
```

4. Make your changes and commit them:

```bash
git add .
git commit -m "Add your commit message here"
```

5. Push your changes to your forked repository:

```bash
git push origin your-feature-branch-name
```

6. Create a new pull request on the original repository and wait for the maintainer to review and merge your changes.
