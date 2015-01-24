class UsersController < ApplicationController
  include ApplicationHelper 

  before_filter :authenticate_user!
  before_action :set_current_business, only: [ :index, :show ]

  def index
				if current_user.admin?
    @users = User.all
				else
				flash[:danger] = "There was a problem with your request, please contact us."
				redirect_to root_path
				end
  end


end
