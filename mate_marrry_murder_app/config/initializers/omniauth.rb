OmniAuth.config.logger = Rails.logger

# #authentication error problem
# Omniauth.config do |config|
#   config.on_failure do
#     # your handling code invoked in the context of a rack app
#   end
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY_MMM'], ENV['FACEBOOK_SECRET_MMM']
end

#ENV['FACEBOOK_KEY_MMM'], ENV['FACEBOOK_SECRET_MMM']