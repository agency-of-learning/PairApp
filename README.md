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

For detailed instructions on how to install these dependencies, please reference our [Wiki step-by-step guide for installing dependencies on Mac or Windows](https://github.com/agency-of-learning/PairApp/wiki/Step%E2%80%90by%E2%80%90step-instructions-to-install-the-dependencies-of-our-application).

You can view open issues [here](https://github.com/orgs/agency-of-learning/projects/1/views/1)

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

3. Running Pre-Flight Checks

In order to pass our continuous integration, your PR will need to pass the RSpec test suite and lint for both Ruby and JavaScript. We've rolled all of this into one command you can run to make sure everything is in order before submitting a PR.

```bash
bin/checks
```

For linting errors, you can pass a flag to Rubocop and/or ESLint to have the tool try to autocorrect any linting offenses:

```bash
# for Rubocop
bundle exec rubocop -a

# for ESLint
yarn eslint --fix
```

4. Push your changes to origin:

```bash
git push origin your-feature-branch-name
```

5. Create a new pull request on the original repository and wait for the maintainer to review and merge your changes.
