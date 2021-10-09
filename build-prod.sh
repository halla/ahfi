export MIX_ENV=prod

cd assets && node_modules/brunch/bin/brunch build --production
cd -

sudo docker run -v $(pwd):/opt/build --rm -it elixir-ubuntu:latest /opt/build/bin/build ahfi_prod
