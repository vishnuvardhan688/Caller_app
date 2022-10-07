# frozen_string_literal: true

require "twilio-ruby"

# This class generates an access token with Twilio lib
class TwilioAccessToken
  def self.generate(role)
    puts "cs: #{$current_account.inspect}"
    # Create Voice grant for our token
    grant = Twilio::JWT::AccessToken::VoiceGrant.new
    grant.outgoing_application_sid = $current_account.app_sid #ENV["TWIML_APPLICATION_SID"]

    # Optional: add to allow incoming calls
    grant.incoming_allow = true

    # Create an Access Token
    token = Twilio::JWT::AccessToken.new(
      $current_account.account_sid,
      $current_account.api_key, #ENV["TWILIO_API_KEY"],
      $current_account.api_secret, #ENV["TWILIO_API_SECRET"],
      [grant],
      identity: role,
    )

    token.to_jwt
  end
end
