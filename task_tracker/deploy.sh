cd assets
export MIX_ENV=prod
export PORT=4747
npm install
node_modules/.bin/webpack --mode production
cd ..
mix phx.digest
mix compile
mix release --env=prod
