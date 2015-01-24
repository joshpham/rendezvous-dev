class PhoneNumber < ActiveRecord::Base
		include SmsHelper

			attr_accessor :verification_code_confirmation
   validates :phone_list_id, presence: true
   validates :number, :numericality => {:only_integer => true}

			before_save :set_phone_attributes, if: :phone_verification_needed?
   after_save :send_sms_for_phone_verification, if: :phone_verification_needed?

			scope :unverified_phones,  -> { where(verified: false) }
			scope :verified_phones,  -> { where(verified: true) }

			belongs_to :phone_list

   has_one :business, through: :phone_list

			def mark_phone_as_verified!
    update!(verified: true, verification_code: nil)
   end

	  def send_success_message!
	    twilio_client.account.sms.messages.create(
	      from: TWILIO_NUMBER,
	      to: formatted_mobile_phone_number,
	      body: "You're now verified! Enjoy the deals. Text #{self.stop_code} to unfollow #{self.phone_list.business.name}."
	    )
	  end

			def mark_stop_service!
    update!(active: false)
   end

	  def send_stop_message!
	    twilio_client.account.sms.messages.create(
	      from: TWILIO_NUMBER,
	      to: formatted_mobile_phone_number,
	      body: "You have stopped following #{self.phone_list.business.name}."
	    )
	  end

			def mark_start_service!
    update!(active: true)
   end

	  def send_start_message!
	    twilio_client.account.sms.messages.create(
	      from: TWILIO_NUMBER,
	      to: formatted_mobile_phone_number,
	      body: "Welcome back! You are now following #{self.phone_list.business.name}."
	    )
	  end

  private


  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH)
  end

  def formatted_mobile_phone_number
    "+1#{self.number}"
  end

  def set_phone_attributes
    self.verified = false
    self.verification_code = generate_phone_verification_code
			 self.stop_code = "STOP#{self.phone_list_id}"
				
    # removes all white spaces, hyphens, and parenthesis
    self.number.gsub!(/[\s\-\(\)]+/, '')
  end

  def send_sms_for_phone_verification
    PhoneVerificationService.new(phone_number_id: id).process
  end

  def generate_phone_verification_code
    begin
     verification_code = SecureRandom.hex(1)
    end while self.class.exists?(verification_code: verification_code)

    verification_code
  end


 # def generate_start_code
 #   begin
   #  start_code = "START#{self.phone_list_id}" 
   # end while self.class.exists?(start_code: start_code)

  #  start_code
 # end

  def phone_verification_needed?
    number.present? && number_changed?
  end
end
