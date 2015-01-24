module ApplicationHelper
  def error_tag(error)
    unless error.blank?
      content_tag(:span, error.is_a?(Array) ? error.first : error, :class => :error)
    end
  end

 private		

    def set_business_by_slug
      @business = Business.find_by_slug(params[:id])
    end

				def set_current_business
				 if signed_in?
					 @user = current_user
			  	@business = @user.business
						end
				end

end