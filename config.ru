require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  map('/songs') { run SongsController}
  map('/genres') { run GenresController}
  map('/artists') { run ArtistsController}
  map('/') { run ApplicationController}
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
