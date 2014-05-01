OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['1469594899941584'], ENV['f3cff3426918a1943d0dfb3fa407ca4f']
end