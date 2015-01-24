class HardWorker
  include Sidekiq::Worker

  def perform(phone_list_id, phone_number_phone_list_id, message_phone_list_id )
								message = Message.find(message_phone_list_id)
								phone_list = PhoneList.find(phone_list_id)

								phone_number_id.find_each do |phone_number|
								phone_number = PhoneNumber.find(phone_number_phone_list_id)
								client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH)
	       send_message = client.messages.create from: TWILIO_NUMBER, 
								to: "+1#{phone_number.number}", 
								body: "hi" 
								end
		end
end
