Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
  provider :facebook, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end
