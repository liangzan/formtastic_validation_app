# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_validation_app_session',
  :secret      => '56eaf91aedf287ac8f9081a0de6cd56adac27891f15c25db7265720a166cb7c4ee5389002f7db91e4e3d2dfe75f0772b8e390a074ec93e2c44c77f29dc5d125a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
