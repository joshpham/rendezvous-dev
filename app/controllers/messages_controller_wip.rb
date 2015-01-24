require 'twilio-ruby'

class MessagesController < ApplicationController
  include SmsHelper

  before_action :set_message, only: [:show, :edit, :update, :destroy]
  
  before_filter :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  respond_to :html

  def index
				if current_user.admin?
    @messages = Message.all
				else
				flash[:danger] = "There was a problem with your request, please contact us."
				redirect_to root_path
				end
  end

  def show
				@message = Message.find(message_params)
    respond_with(@message)
  end

  def new
				@message = Message.new
    respond_with(@message)
  end

  def edit
  end

  def create
				@phone_list = current_user.business.phone_list
				@phone_number = PhoneNumber.where(:phone_list_id => @phone_list.id, :verified => true, :active => true)
    @message = Message.new(message_params)
	    if @message.save
				  	HardWorker.perform_async(@phone_list, @phone_number, @message.phone_list_id )
					end
				flash[:notice] = 'Sent Text Message!'
    redirect_to root_path
  end


  def update
    @message.update(message_params)
    respond_with(@message)
  end

  def destroy
    @message.destroy
				flash[:notice] = 'Deal removed.'
    redirect_to root_path
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:message, :sent_on, :phone_list_id)
    end
end
