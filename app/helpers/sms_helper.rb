module SmsHelper

  TWILIO_SID = Rails.application.secrets.twilio_account_sid
  TWILIO_AUTH = Rails.application.secrets.twilio_auth_token
  TWILIO_NUMBER = Rails.application.secrets.twilio_number

end
