class PhoneListsController < ApplicationController
		include ApplicationHelper

  before_filter :authenticate_user!
  before_action :set_phone_list, only: [:show, :edit, :update, :destroy]
  before_action :set_current_business, only: [ :index, :show, :edit, :update, :destroy ]

  respond_to :html

  def index
	if current_user.admin?
        @phone_lists = PhoneList.all
	else
    	flash[:danger] = "There was a problem with your request, please contact us."
    	redirect_to root_path
	end
  end

  def show
    @phone_numbers = PhoneNumber.where(:phone_list_id => @phone_list.id)
    respond_with(@phone_list)
  end

  def new
    @phone_list = PhoneList.new
    respond_with(@phone_list)
  end

  def edit
  end

  def create
    @phone_list = PhoneList.new(phone_list_params)
    @phone_list.business_id = current_user.business.id
    @phone_list.save
    respond_with(@phone_list)
  end



  def update
    @phone_list.update(phone_list_params)
    respond_with(@phone_list)
  end

  def destroy
    @phone_list.destroy
    respond_with(@phone_list)
  end

  private
    def set_phone_list
        @phone_list = PhoneList.find(params[:id])
    end

    def phone_list_params
        params.require(:phone_list).permit(:user_id, :business_id, :name)
    end
end
