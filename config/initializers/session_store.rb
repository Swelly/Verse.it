# Be sure to restart your server when you modify this file.

# No longer using cookie based sessions. Using Redis cache instead
VerseApp::Application.config.session_store :redis_store

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# VerseApp::Application.config.session_store :active_record_store
