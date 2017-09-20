#/bin/bash
export MIX_ENV=prod

cd assets && node_modules/brunch/bin/brunch build --production
cd -
mix phx.digest
mix release
rsync -r _build/prod/rel/ahfi/ ws007.anywheris.com:/srv/www/ahfi_prod
