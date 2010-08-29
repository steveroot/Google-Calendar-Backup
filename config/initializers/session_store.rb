# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_GoogleCalendarChangeMonitor_session',
  :secret      => 'a2ab676d35fea90ecbb2383a0e69469dd78115162d444e62f65ddaaefa621e98de2e906761b269a2f0d5c5c78efc915a8af7192c2f93c9d1fb7a9f61a4854593'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
