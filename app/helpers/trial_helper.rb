module TrialHelper

   def account_type
		   if current_user.status == 1
					"Gold"
					elsif current_user.status == 2
     "Platinum"
					elsif current_user.status == 3
     "Diamond"
					else
     "Trial"
					end
			end			

   def remaining_days
			 current_user
				 if current_user.status == 0
					((current_user.created_at + 30.days).to_date - Date.today).round
					end
   end

			def trial_expired?
			  if signed_in?
						current_user
						if current_user.status == 0
							 if remaining_days <= 0
											flash[:danger] = "Your Trial period is now over. Please select a Subscription Package."
											redirect_to "/payments/plans"
							 end
						end
					end
			 end

				def account_information_message
				  current_user
						if current_user.status == 0
									"<div class='trial'>Your Trial will expire in #{remaining_days} days.</div>"
						else 
									"<div class='account'>Your Account Type is #{account_type}</div>"
						end
				end
end

