class PaymentsController < ApplicationController
		include ApplicationHelper

  before_filter :authenticate_user!
  before_action :set_current_business, except: [ :create ]	
	
  layout "application_stripe"

  def billing
  end

  def plans
  end

  def new_gold
  end

  def new_platinum
  end

  def new_diamond
  end

  def create
    if stripe_token = params[:stripe_token]
      if current_user.do_subscription_transaction(params[:payment_type], stripe_token)
        flash[:notice] = 'Card charged successfully!'
      else
        flash[:danger] = 'Something went wrong, please double check card details.' 
      end
    else
        flash[:alert] = 'You did not submit the form correctly'
    end
    redirect_to root_path
  end


end
