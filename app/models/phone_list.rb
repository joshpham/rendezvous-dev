class PhoneList < ActiveRecord::Base
   validates :business_id, presence: true
			before_create :set_link_list

			belongs_to :business, :dependent => :destroy
			has_many :phone_numbers
  private
    def set_link_list
      self.name = business.slug
						self.id = business.id
    end


end
