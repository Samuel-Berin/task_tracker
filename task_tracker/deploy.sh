#Taken fron Nat's notes, as well as previous deploy scripts provided by Nat


echo "Stopping old copy of app"
_build/prod/rel/task_tracker/bin/task_tracker stop || true

git pull
cd assets
export MIX_ENV=prod
export PORT=4747
npm install
node_modules/.bin/webpack --mode production
cd ..
mix phx.digest
mix compile
mix release --env=prod
_build/prod/rel/task_tracker/bin/task_tracker start
