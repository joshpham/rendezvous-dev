class PhoneNumbersController < ApplicationController
		include ApplicationHelper
  include SmsHelper

  before_filter :authenticate_user!, except: [ :create ]
  before_action :set_current_business, only: [ :index, :show, :edit, :update, :destroy ]
  before_action :set_phone_number, only: [ :show, :edit, :update, :destroy ]

  respond_to :html

  def index
	if current_user.admin?
    @phone_numbers = PhoneNumber.all
	else
	flash[:danger] = "There was a problem with your request, please contact us."
	redirect_to root_path
	end
  end

  def show
    respond_with(@phone_number)
  end

  def new
    @phone_number = PhoneNumber.new
    respond_with(@phone_number)
  end


  def edit
  end

  def create
    @phone_number = PhoneNumber.new(phone_number_params)
    if @phone_number.save
	    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH)
        flash[:notice] = 'Thanks! Verification Code sent! Please reply to complete!'
    else
        flash[:danger] = 'Please enter a valid phone number.'
    end
    redirect_to root_path
  end

  def update
    @phone_number.update(phone_number_params)
        if @phone_number.update
            client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH)
            send_message = client.messages.create from: TWILIO_NUMBER, to: "+1#{@phone_number.number}", body: "Yay."
            flash[:notice] = 'Updated!'
            else
				flash[:danger] = 'Error.'
        end
        redirect_to root_path
  end



  def destroy
    @phone_number.destroy
    respond_with(@phone_number)
  end

  private
    def set_phone_number
        @phone_number = PhoneNumber.find(params[:id])
    end

    def phone_number_params
		params.require(:phone_number).permit(:number, :phone_list_id, :verified, :verification_code) 
    end
end
