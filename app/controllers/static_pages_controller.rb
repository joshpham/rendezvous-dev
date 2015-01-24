class StaticPagesController < ApplicationController
 include TrialHelper 
 include ApplicationHelper 

  layout "application_module", :only => [ :show ]

  before_filter :trial_expired?, :only => [ :home ]
  before_action :set_current_business, only: [ :home ]

  respond_to :html

  def home
				if signed_in?
							@phone_list = @business.phone_list
							@phone_numbers = PhoneNumber.where(:phone_list_id => @phone_list.id)
							@messages = Message.where(:phone_list_id => @phone_list.id)
							@message = Message.new
					else
				redirect_to businesses_path
				end
  end

		def show
				@business = Business.find_by_slug(params[:id])
    @phone_number = PhoneNumber.new
  end

  def about
  end

  def contact
  end


end
