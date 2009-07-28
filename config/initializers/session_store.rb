# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bugmash_scoreboard_session',
  :secret      => '3bced9976c68e90da9e16da506fae2586445b97d9aa21e70381b4e48ce84868ad635ca4868e1e69080bb33932db144c5ad2249340ee48e121a445c0a77ecfe8c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
