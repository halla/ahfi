#/bin/bash
export MIX_ENV=prod

node_modules/brunch/bin/brunch build --production
mix phoenix.digest
mix release
rsync -r _build/prod/rel/ahfi/ ws007.anywheris.com:/srv/www/ahfi_prod
