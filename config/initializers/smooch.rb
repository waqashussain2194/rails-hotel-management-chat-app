# Setup authorization
SmoochApi.configure do |config|
  config.api_key['Authorization'] = ENV.fetch('SMOOCH_JWT_TOKEN')
  config.api_key_prefix['Authorization'] = 'Bearer'
end
