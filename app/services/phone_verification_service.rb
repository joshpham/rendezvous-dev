class PhoneVerificationService
		include SmsHelper
		attr_reader :phone_number

  def initialize(options)
    @phone_number = PhoneNumber.find(options[:phone_number_id])
  end


  def process
    send_sms
  end

  private

  def from
    TWILIO_NUMBER
  end

  def to
    # +1 is a country code for USA
    "+1#{phone_number.number}"
  end

  def body
    "Hello from the O! Please reply with this code '#{phone_number.verification_code}' to verify your number and receive deals from #{phone_number.phone_list.business.name}"
  end

  def twilio_client
    # Pass your twilio account sid and auth token
    @twilio = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH)

  end

  def send_sms
    Rails.logger.info "SMS: From: #{from} To: #{to} Body: \"#{body}\""

    twilio_client.account.messages.create(
      from: from,
      to: to,
      body: body
    )
  end

end