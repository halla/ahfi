# Ahfi

My personal website (https://anttihalla.fi) on Phoenix Framework / Elixir.

This is in no way complete or ready for general use as-is. I'm slowly working towards
making this more generic though, and you might find it useful for reference, especially
if you're trying to get started with Phoenix & Elixir yourself.

## Features

* Static pages in code base
* Blog posts in database (PostgreSql)
* Contact form
  * stores to db
  * send email
  * sends Slack notification
* File upload
* Single-user password authentication
* Distillery release
  * Package standalone release with Erlang Runtime
  * Command to run db migration tasks on server
* Phoenix 1.3 project structure

### Roadmap

* Basic admin interface
* Pages to Db
* Media library interface
* Better content creation/editing/publishing interface
*

## Basics

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


## Publishing

* ./deploy-prod.sh
* apps are separate things,
  * socrateaser via nginx conf

### Restart server

* sudo systemctl restart ahfi


## Publishing, the old way

localhost
* git commit, push

server
* git pull
* MIX_ENV=prod mix compile
* iex -S mix phoenix.server
* export MIX_ENV="prod"
* mix compile
* mix phoenix.digest


Digestit
* phoenix.digest tekee vain digestoinnin. kopiointi webistä priviin tapahtuu jossain muualla?


## Distillery release and deployment

* ssh ws007.anywheris.com -L 5433:localhost:5432 -N
* MIX_ENV=prod mix release
* ./deploy-prod.sh

On server
* sudo systemctl restart ahfi
* check permissions /srv/www/ahfi_prod/var especially
* chmod g+s directory/  --sticky for default group ownership (www-data)

* Migrations
  * bin/ahfi migrate
