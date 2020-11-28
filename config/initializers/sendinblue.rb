require 'sib-api-v3-sdk'

# Setup authorization
SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV['SENDINBLUE_API_TOKEN']
  config.api_key['partner-key'] = ENV['SENDINBLUE_API_TOKEN']
end

api_instance = SibApiV3Sdk::AccountApi.new

begin
  result = api_instance.get_account
  p result
rescue SibApiV3Sdk::ApiError => e
  puts "Exception when calling AccountApi->get_account: #{e}"
end
