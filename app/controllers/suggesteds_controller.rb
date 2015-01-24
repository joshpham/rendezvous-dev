class SuggestedsController < ApplicationController
  before_action :set_suggested, only: [:show, :edit, :update, :destroy]

  layout "application_public", :only => [ :index ]
		layout "application_module", :only => [ :new ]

  respond_to :html

  def index
    @suggesteds = Suggested.all
    respond_with(@suggesteds)
  end

  def show
    respond_with(@suggested)
  end

  def new
    @suggested = Suggested.new
    respond_with(@suggested)
  end

  def edit
  end

  def create
    @suggested = Suggested.new(suggested_params)
    flash[:notice] = 'Thank you. Business Suggested!' if @suggested.save
    redirect_to root_path
  end

  def update
    flash[:notice] = 'Suggested was successfully updated.' if @suggested.update(suggested_params)
    respond_with(@suggested)
  end

  def destroy
    @suggested.destroy
    respond_with(@suggested)
  end

  private
    def set_suggested
      @suggested = Suggested.find(params[:id])
    end

    def suggested_params
      params.require(:suggested).permit(:name)
    end
end
