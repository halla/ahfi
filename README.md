# Ahfi

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
