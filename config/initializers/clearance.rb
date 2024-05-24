Clearance.configure do |config|
  config.allow_sign_up = true
  config.cookie_domain = ->(request) { request.host }
  config.cookie_expiration = ->(_) { 1.year.from_now.utc }
  config.cookie_name = 'remember_token'
  config.cookie_path = '/'
  config.routes = true
  config.httponly = true
  config.mailer_sender = ENV.fetch('MAILER_SENDER', nil)
  config.password_strategy = Clearance::PasswordStrategies::BCrypt
  config.redirect_url = '/'
  config.url_after_destroy = nil
  config.url_after_denied_access_when_signed_out = nil
  config.rotate_csrf_on_sign_in = true
  config.same_site = nil
  config.secure_cookie = Rails.configuration.force_ssl
  config.signed_cookie = true
  config.sign_in_guards = []
  config.user_model = 'User'
  config.parent_controller = 'ApplicationController'
  config.sign_in_on_password_reset = false
end
