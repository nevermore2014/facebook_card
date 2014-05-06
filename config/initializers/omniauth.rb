OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], {
    # Disables CSRF protection -- needed to fix:
    # https://github.com/mkdynamic/omniauth-facebook/issues/73
    # Would be very bad on a production site due to security risk!
    provider_ignores_state: true
  }


end

# OmniAuth.config.on_failure = Proc.new { |env|
#   OmniAuth::FailureEndpoint.new(env).redirect_to_failure
# }