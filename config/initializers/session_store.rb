# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_linker_new_session',
  :secret      => '7e9961bb61ca56acd3df79f7ee03c175c1e38768cd7e4fac6c5b664b033bbd32ccfd5f7323aa69c3e20585e7c23483987fbe74f556becafa19173f57b2aa0a9a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
