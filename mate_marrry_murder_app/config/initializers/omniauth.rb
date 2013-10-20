OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY_MMM'], ENV['FACEBOOK_SECRET_MMM']
end

#ENV['FACEBOOK_KEY_MMM'], ENV['FACEBOOK_SECRET_MMM']