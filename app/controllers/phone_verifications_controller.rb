class PhoneVerificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  layout "application_public"

  def verify_from_message
    if phone_number = get_phone_number_for_phone_verification
       phone_number.mark_phone_as_verified! if phone_number
       phone_number.send_success_message! if phone_number
				else
												phone_number = get_stop_service
										 	phone_number.mark_stop_service! if phone_number
												phone_number.send_stop_message! if phone_number
				end
				render nothing: true
  end



  private

  def get_phone_number_for_phone_verification
    verification_code = params['Body'].try(:strip)
    number            = params['From'].gsub('+1', '')

    condition = { verification_code: verification_code,
                  number: number }

    PhoneNumber.unverified_phones.find_by(condition)
  end

  def get_stop_service
    stop_code = params['Body'].try(:strip)
    number    = params['From'].gsub('+1', '')

    condition = { stop_code: stop_code,
                  number: number }

    PhoneNumber.verified_phones.where(condition).first
  end




end