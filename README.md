# Advizer

## Setup

To start Advizer app:
  * Make sure you have Elixir installed in your machine, check version in `.github/workflows/elixir.yml`
  * Make sure you have a local Postgres setup with a `postgres` user and `postgres` as password.
  * Export environment variable ADVIZER_SERAPHIN_API_KEY
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Mails can be check on [`local mailbox`](http://localhost:4000/dev/mailbox)

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Launch the tests

Simply run `mix test`.

## Deployment

The application is deployed on Heroku, with automatic deployment upon successful build on Github Actions.
You can visit https://advizer.herokuapp.com.

## Enhancements

* The live mailing is not setup with Swoosh. It would require provisionning SES on AWS (among other solutions) and 
adapt the production configuration with needed keys and credentials.
* Live version with huge number of requested quotation and more complex computation of the advise would have 
been a good use case to use something like [`Broadway`](https://elixir-broadway.org/) and distribute the 
processing of the quotation/advice as jobs.
* Testing against the live API of Seraphin is not good, I should have made an environment set module so that 
in TEST, `Seraphin.Quoter` uses the stub instead of the API.