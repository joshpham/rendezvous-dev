class BusinessesController < ApplicationController
  include ApplicationHelper
		
  layout "application_public", :only => [ :index ]

  before_filter :authenticate_user!, only: [ :new, :create, :show, :update, :destroy ]
  before_action :set_business_by_slug, only: [ :show, :update, :destroy ]

  respond_to :html

  def index   
    if params[:search]
     @businesses = Business.search(params[:search]).order("created_at DESC")
    else
     @businesses = Business.all.order('created_at DESC')
    end
  end

  def show
  end

  def new
    @user = current_user
    @business = Business.new
    @phone_list = PhoneList.new
    respond_with(@business)
  end

  def edit
  end

  def create
    @user = current_user
    @business = current_user.build_business(business_params)
    @user.business = @business
    if @business.save
        @business_phone_list = PhoneList.new(params[:id])
        @business_phone_list.business_id = current_user.business.id
      	flash[:notice] = 'Business Account Registration - Successful.' if @business_phone_list.save
    end
        redirect_to root_path
  end


  def update
    flash[:notice] = 'Business was successfully updated.' if @business.update(business_params)
    redirect_to root_path
  end

  def destroy
    if @business.present?
      @business.destroy
    end
    redirect_to businesses_path
  end

  private

    def business_params
        params.require(:business).permit(:name, :user_id, :slug, :state, :city, :hours)
    end

end
