# XERO SERVICE

 The web application incorporates the Xero SDK, a suite of software tools designed for efficient management of accounts within the Xero platform. Xero stands as a cloud-based solution tailored for the streamlined administration of small-scale enterprises, offering comprehensive features for order accounting, payment processing, and generating insightful reports.

# Getting started

Before we start you must be sure that you have installed:

- [RVM](http://rvm.io/rvm/install)
- [Ruby 3.2.2](https://gist.github.com/pboksz/4649025)
- [Ruby on Rais 7+ version](https://guides.rubyonrails.org/v5.1/getting_started.html)
- [PostgreSQL](https://www.postgresql.org/docs/current/tutorial-install.html)
- [Docker](https://docs.docker.com/engine/install/)
- [Npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stablehttps://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)

## Installation
You can clone an existing repository from GitHub.com to your local computer, or to a codespace:

```sh
   $ git clone https://github.com/DariaAres/xero-service.git
```

## Configure

1. Change directory to `xero-service` and go to branch `xero-control`:

    ```sh
    $ cd xero-service
    $ git checkout xero-control
    ```

1. Installing dependencies:

    ```sh
    $ sudo apt install -yqq libpq-dev
    $ gem install bundler
    $ bundle install
    $ yarn install
    $ yarn run build
    ```

1. You can go to `.env.example`, rename it to `.env` and change following values: `POSTGRES_USER` is a username that you created to authenticate in MySQL; `POSTGRES_PASSWORD` is the password with which your `POSTGRES_USER` can authenticate; `CLIENT_ID` is your id in Xero account; `CLIENT_SECRET` is a key that you generate in your Xero account. You mast get something like that: 

    ```sh
    $ POSTGRES_USER=username
    $ POSTGRES_PASSWORD=password
    $ CLIENT_ID='id'
    $ CLIENT_SECRET='key'
    $ REDIRECT_URI='http://localhost:3000/callback'
    $ SCOPES="openid profile email"
    ```

1. Then you should create the databases defined in the current environment, run pending migrations and fill the current database with data defined in `db/seeds.rb`:

    ```sh
    $ rails db:create db:migrate db:seed
    ```

## Usage

- ### Start the web server locally

    This command launches a web server named Puma which comes bundled with Rails:

    ```sh
    $ rails s
    ```
    You'll use this any time you want to access your application through a web browser.

    Run with `--help` or `-h` for options.

- ### Start the web server with docker
    First of all, you need to build the project into an image file:

    ```sh
    $ docker compose build
    ```

    Now that the project is built, it's time to run it. This step of our work corresponds to the step where, when working with individual containers, the `docker run` command is executed:

    ```sh
    $ docker compose up
    ```
    Run with `--help` or `-h` for options.

## Testing

- ### Start rspec tests locally

    First of all you need to make sure that you have installed all gems:

    ```sh
    $ bundle install
    ```

    Then we can run rspec tests by the following command:

    ```sh
    $ bundle rspec
    ```

- ### Start rspec tests with docker

    If you have run and built app container, you can execute `bundle exec rspec` inside of the container:

    ```sh
    $ docker exec -it list bundle exec rspec
    ```

## License

This code is free to use under the terms of the MIT license.
